import { NextRequest, NextResponse } from "next/server";
import prisma from "@/prisma/client";
import { createSchema } from "./schema";
import { Prisma } from "@prisma/client";

export async function GET(request: NextRequest) {
  const claim = await prisma.claim.findMany({
    take: 25,
    orderBy: {
        claimDatetime: 'desc'
    }
  });
  return NextResponse.json(claim);
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const validation = createSchema.safeParse(body);

    if (!validation.success)
      return NextResponse.json(validation.error.errors, { status: 400 });

    const newClaim = await prisma.claim.create({
      data: {
        claimDatetime: body.claimDatetime,
        nodeName: body.nodeName,
        slot: body.slot,
        type: body.type
      },
    });

    return NextResponse.json(newClaim, { status: 201 });

  } catch (e) {
    if (e instanceof Prisma.PrismaClientKnownRequestError) {
        return NextResponse.json({'error': e.message}, { status: 400 });
    } else {
        console.error(e)
        return NextResponse.json({'error': 'Server Error'}, { status: 500 });
    }
  }
}