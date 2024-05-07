/*
  Warnings:

  - You are about to drop the column `piece_cache_pct` on the `Node` table. All the data in the column will be lost.
  - You are about to drop the column `port` on the `Node` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "Farmer" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "workers" INTEGER,
    "pieceCachePct" REAL,
    "farmIp" TEXT,
    "nodeId" INTEGER NOT NULL,
    CONSTRAINT "Farmer_nodeId_fkey" FOREIGN KEY ("nodeId") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Farm" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "farmerId" INTEGER NOT NULL,
    "index" INTEGER NOT NULL,
    "publicKey" TEXT,
    "allocatedSpace" REAL,
    "directory" TEXT,
    "status" TEXT,
    CONSTRAINT "Farm_farmerId_fkey" FOREIGN KEY ("farmerId") REFERENCES "Farmer" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "NodeEvent" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "eventDatetime" DATETIME NOT NULL,
    "nodeId" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "data" TEXT NOT NULL,
    CONSTRAINT "NodeEvent_nodeId_fkey" FOREIGN KEY ("nodeId") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "FarmerEvent" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "eventDatetime" DATETIME NOT NULL,
    "farmerId" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "data" TEXT NOT NULL,
    CONSTRAINT "FarmerEvent_farmerId_fkey" FOREIGN KEY ("farmerId") REFERENCES "Farmer" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Plot" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "plotDatetime" DATETIME NOT NULL,
    "farmId" INTEGER NOT NULL,
    "percentComplete" REAL NOT NULL,
    "currentSector" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    CONSTRAINT "Plot_farmId_fkey" FOREIGN KEY ("farmId") REFERENCES "Farm" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Reward" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "rewardDatetime" DATETIME NOT NULL,
    "farmId" INTEGER NOT NULL,
    "hash" TEXT NOT NULL,
    "success" BOOLEAN NOT NULL,
    CONSTRAINT "Reward_farmId_fkey" FOREIGN KEY ("farmId") REFERENCES "Farm" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Claim" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "claimDatetime" DATETIME NOT NULL,
    "nodeId" INTEGER NOT NULL,
    CONSTRAINT "Claim_nodeId_fkey" FOREIGN KEY ("nodeId") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Consensus" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "consensusDatetime" DATETIME NOT NULL,
    "nodeId" INTEGER NOT NULL,
    CONSTRAINT "Consensus_nodeId_fkey" FOREIGN KEY ("nodeId") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "FarmerError" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "errorDatetime" DATETIME NOT NULL,
    "farmerId" INTEGER NOT NULL,
    "message" TEXT NOT NULL,
    CONSTRAINT "FarmerError_farmerId_fkey" FOREIGN KEY ("farmerId") REFERENCES "Farmer" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "NodeError" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "errorDatetime" DATETIME NOT NULL,
    "nodeId" INTEGER NOT NULL,
    "message" TEXT NOT NULL,
    CONSTRAINT "NodeError_nodeId_fkey" FOREIGN KEY ("nodeId") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Node" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Initializing',
    "ip" TEXT
);
INSERT INTO "new_Node" ("createdAt", "id", "ip", "name", "status") SELECT "createdAt", "id", "ip", "name", "status" FROM "Node";
DROP TABLE "Node";
ALTER TABLE "new_Node" RENAME TO "Node";
CREATE UNIQUE INDEX "Node_name_key" ON "Node"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "Farmer_name_key" ON "Farmer"("name");
