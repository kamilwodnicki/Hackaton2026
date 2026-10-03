from __future__ import annotations

from decimal import Decimal

import psycopg2
from psycopg2 import sql

from .scraper import Indicator


def connect(database_url: str | None, db_config: dict[str, str | int | None]):
    if database_url:
        return psycopg2.connect(database_url)
    return psycopg2.connect(**db_config)


def save_to_postgres(
    connection,
    indicators: list[Indicator],
    data: dict[str, dict[str, Decimal | None]],
) -> None:
    columns = [indicator.column_name for indicator in indicators]
    if len(columns) != len(set(columns)):
        raise ValueError("Wygenerowano powtarzające się nazwy kolumn.")

    with connection:
        with connection.cursor() as cursor:
            cursor.execute(
                "CREATE TABLE IF NOT EXISTS ioss "
                "(powiat TEXT PRIMARY KEY)"
            )
            for indicator in indicators:
                identifier = sql.Identifier(indicator.column_name)
                cursor.execute(
                    sql.SQL("ALTER TABLE ioss ADD COLUMN IF NOT EXISTS {} NUMERIC").format(identifier)
                )
                cursor.execute(
                    sql.SQL("COMMENT ON COLUMN ioss.{} IS %s").format(identifier),
                    (
                        f"{indicator.name} "
                        f"(IOSS id={indicator.indicator_id}, najnowszy dostępny rok={indicator.year})",
                    ),
                )

            insert_columns = ["powiat", *columns]
            statement = sql.SQL(
                "INSERT INTO ioss ({fields}) VALUES ({values}) "
                "ON CONFLICT (powiat) DO UPDATE SET {updates}"
            ).format(
                fields=sql.SQL(", ").join(map(sql.Identifier, insert_columns)),
                values=sql.SQL(", ").join(sql.Placeholder() for _ in insert_columns),
                updates=sql.SQL(", ").join(
                    sql.SQL("{column} = EXCLUDED.{column}").format(column=sql.Identifier(column))
                    for column in columns
                ),
            )
            for county in sorted(data):
                values = [county, *(data[county].get(column) for column in columns)]
                cursor.execute(statement, values)
