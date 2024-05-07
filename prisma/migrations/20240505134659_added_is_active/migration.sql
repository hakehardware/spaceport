/*
  Warnings:

  - Added the required column `active` to the `Farmer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `active` to the `Node` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Farmer" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL,
    "workers" INTEGER,
    "pieceCachePct" REAL,
    "farmIp" TEXT,
    "nodeId" INTEGER NOT NULL,
    CONSTRAINT "Farmer_nodeId_fkey" FOREIGN KEY ("nodeId") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Farmer" ("createdAt", "farmIp", "id", "name", "nodeId", "pieceCachePct", "workers") SELECT "createdAt", "farmIp", "id", "name", "nodeId", "pieceCachePct", "workers" FROM "Farmer";
DROP TABLE "Farmer";
ALTER TABLE "new_Farmer" RENAME TO "Farmer";
CREATE UNIQUE INDEX "Farmer_name_key" ON "Farmer"("name");
CREATE TABLE "new_Node" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Initializing',
    "active" BOOLEAN NOT NULL,
    "ip" TEXT
);
INSERT INTO "new_Node" ("createdAt", "id", "ip", "name", "status") SELECT "createdAt", "id", "ip", "name", "status" FROM "Node";
DROP TABLE "Node";
ALTER TABLE "new_Node" RENAME TO "Node";
CREATE UNIQUE INDEX "Node_name_key" ON "Node"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
