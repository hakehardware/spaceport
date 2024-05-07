/*
  Warnings:

  - You are about to drop the column `ip` on the `Node` table. All the data in the column will be lost.
  - Added the required column `containerStarted` to the `Node` table without a default value. This is not possible if the table is not empty.
  - Added the required column `containerStatus` to the `Node` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hostIp` to the `Node` table without a default value. This is not possible if the table is not empty.
  - Added the required column `version` to the `Node` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Node" (
    "name" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Initializing',
    "active" BOOLEAN NOT NULL,
    "hostIp" TEXT NOT NULL,
    "containerStatus" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "containerStarted" DATETIME NOT NULL
);
INSERT INTO "new_Node" ("active", "createdAt", "name", "status", "updatedAt") SELECT "active", "createdAt", "name", "status", "updatedAt" FROM "Node";
DROP TABLE "Node";
ALTER TABLE "new_Node" RENAME TO "Node";
CREATE UNIQUE INDEX "Node_name_key" ON "Node"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
