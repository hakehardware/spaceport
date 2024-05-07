/*
  Warnings:

  - You are about to drop the column `farmIp` on the `Farmer` table. All the data in the column will be lost.
  - Added the required column `best` to the `Consensus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `bps` to the `Consensus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `downSpeed` to the `Consensus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `finalized` to the `Consensus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `peers` to the `Consensus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `target` to the `Consensus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `upSpeed` to the `Consensus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `claimType` to the `Claim` table without a default value. This is not possible if the table is not empty.
  - Added the required column `slot` to the `Claim` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Consensus" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "consensusDatetime" DATETIME NOT NULL,
    "nodeName" TEXT NOT NULL,
    "peers" INTEGER NOT NULL,
    "best" INTEGER NOT NULL,
    "target" INTEGER NOT NULL,
    "finalized" INTEGER NOT NULL,
    "bps" INTEGER NOT NULL,
    "downSpeed" REAL NOT NULL,
    "upSpeed" REAL NOT NULL,
    CONSTRAINT "Consensus_nodeName_fkey" FOREIGN KEY ("nodeName") REFERENCES "Node" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Consensus" ("consensusDatetime", "id", "nodeName") SELECT "consensusDatetime", "id", "nodeName" FROM "Consensus";
DROP TABLE "Consensus";
ALTER TABLE "new_Consensus" RENAME TO "Consensus";
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
    CONSTRAINT "Farmer_nodeName_fkey" FOREIGN KEY ("nodeName") REFERENCES "Node" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Farmer" ("active", "createdAt", "name", "nodeName", "pieceCachePct", "updatedAt", "workers") SELECT "active", "createdAt", "name", "nodeName", "pieceCachePct", "updatedAt", "workers" FROM "Farmer";
DROP TABLE "Farmer";
ALTER TABLE "new_Farmer" RENAME TO "Farmer";
CREATE UNIQUE INDEX "Farmer_name_key" ON "Farmer"("name");
CREATE TABLE "new_Node" (
    "name" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Initializing',
    "active" BOOLEAN NOT NULL,
    "hostIp" TEXT NOT NULL,
    "containerIp" TEXT NOT NULL DEFAULT '',
    "containerStatus" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "containerStartedAt" DATETIME NOT NULL
);
INSERT INTO "new_Node" ("active", "containerStartedAt", "containerStatus", "createdAt", "hostIp", "name", "status", "updatedAt", "version") SELECT "active", "containerStartedAt", "containerStatus", "createdAt", "hostIp", "name", "status", "updatedAt", "version" FROM "Node";
DROP TABLE "Node";
ALTER TABLE "new_Node" RENAME TO "Node";
CREATE UNIQUE INDEX "Node_name_key" ON "Node"("name");
CREATE TABLE "new_Claim" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "claimDatetime" DATETIME NOT NULL,
    "nodeName" TEXT NOT NULL,
    "slot" INTEGER NOT NULL,
    "claimType" TEXT NOT NULL,
    CONSTRAINT "Claim_nodeName_fkey" FOREIGN KEY ("nodeName") REFERENCES "Node" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Claim" ("claimDatetime", "id", "nodeName") SELECT "claimDatetime", "id", "nodeName" FROM "Claim";
DROP TABLE "Claim";
ALTER TABLE "new_Claim" RENAME TO "Claim";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
