import { NextRequest, NextResponse } from "next/server";
import prisma from "@/prisma/client";
import { createSchema } from "./schema";
import { Prisma } from "@prisma/client";

export async function GET(request: NextRequest) {
  const consensus = await prisma.consensus.findMany({
    take: 25,
    orderBy: {
        consensusDatetime: 'desc'
    }
  });
  return NextResponse.json(consensus);
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const validation = createSchema.safeParse(body);

    if (!validation.success)
      return NextResponse.json(validation.error.errors, { status: 400 });

    const newConsensus = await prisma.consensus.create({
      data: {
        consensusDatetime: body.consensusDatetime,
        nodeName: body.nodeName,
        type: body.type,
        peers: body.peers,
        best: body.best,
        target: body.target,
        finalized: body.finalized,
        bps: body.bps,
        downSpeed: body.downSpeed,
        upSpeed: body.upSpeed
      },
    });

    return NextResponse.json(newConsensus, { status: 201 });

  } catch (e) {
    if (e instanceof Prisma.PrismaClientKnownRequestError) {
        return NextResponse.json({'error': e.message}, { status: 400 });
    } else {
        console.error(e)
        return NextResponse.json({'error': 'Server Error'}, { status: 500 });
    }
  }
}