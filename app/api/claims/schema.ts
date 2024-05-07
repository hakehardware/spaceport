import { z } from 'zod';

export const createSchema = z.object({
    claimDatetime: z.string().datetime(),
    nodeName: z.string(),
    slot: z.number(),
    type: z.enum(['Vote', 'Block'])
})