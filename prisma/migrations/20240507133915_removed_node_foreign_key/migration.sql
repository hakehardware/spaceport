/*
  Warnings:

  - You are about to drop the column `nodeName` on the `Farmer` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Farmer" (
    "name" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "active" BOOLEAN NOT NULL,
    "workers" INTEGER,
    "pieceCachePct" REAL,
    "nodeIp" TEXT,
    "containerIp" TEXT,
    "version" TEXT NOT NULL,
    "containerStartedAt" DATETIME NOT NULL
);
INSERT INTO "new_Farmer" ("active", "containerIp", "containerStartedAt", "createdAt", "name", "nodeIp", "pieceCachePct", "updatedAt", "version", "workers") SELECT "active", "containerIp", "containerStartedAt", "createdAt", "name", "nodeIp", "pieceCachePct", "updatedAt", "version", "workers" FROM "Farmer";
DROP TABLE "Farmer";
ALTER TABLE "new_Farmer" RENAME TO "Farmer";
CREATE UNIQUE INDEX "Farmer_name_key" ON "Farmer"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
