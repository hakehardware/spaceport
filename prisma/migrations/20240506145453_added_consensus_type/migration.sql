-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Consensus" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "consensusDatetime" DATETIME NOT NULL,
    "nodeName" TEXT NOT NULL,
    "type" TEXT NOT NULL DEFAULT '',
    "peers" INTEGER NOT NULL,
    "best" INTEGER NOT NULL,
    "target" INTEGER NOT NULL,
    "finalized" INTEGER NOT NULL,
    "bps" INTEGER NOT NULL,
    "downSpeed" REAL NOT NULL,
    "upSpeed" REAL NOT NULL,
    CONSTRAINT "Consensus_nodeName_fkey" FOREIGN KEY ("nodeName") REFERENCES "Node" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Consensus" ("best", "bps", "consensusDatetime", "downSpeed", "finalized", "id", "nodeName", "peers", "target", "upSpeed") SELECT "best", "bps", "consensusDatetime", "downSpeed", "finalized", "id", "nodeName", "peers", "target", "upSpeed" FROM "Consensus";
DROP TABLE "Consensus";
ALTER TABLE "new_Consensus" RENAME TO "Consensus";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
