/*
  Warnings:

  - Added the required column `containerStartedAt` to the `Farmer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `version` to the `Farmer` table without a default value. This is not possible if the table is not empty.

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
    "nodeName" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "containerStartedAt" DATETIME NOT NULL,
    CONSTRAINT "Farmer_nodeName_fkey" FOREIGN KEY ("nodeName") REFERENCES "Node" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Farmer" ("active", "containerIp", "createdAt", "name", "nodeIp", "nodeName", "pieceCachePct", "updatedAt", "workers") SELECT "active", "containerIp", "createdAt", "name", "nodeIp", "nodeName", "pieceCachePct", "updatedAt", "workers" FROM "Farmer";
DROP TABLE "Farmer";
ALTER TABLE "new_Farmer" RENAME TO "Farmer";
CREATE UNIQUE INDEX "Farmer_name_key" ON "Farmer"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
