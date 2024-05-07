import { z } from 'zod';

export const createSchema = z.object({
    consensusDatetime: z.string().datetime(),
    nodeName: z.string(),
    type: z.enum(['Idle Node', 'Syncing']),
    peers: z.number(),
    best: z.number(),
    target: z.number(),
    finalized: z.number(),
    bps: z.number(),
    downSpeed: z.number(),
    upSpeed: z.number()
})