Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413C230C86
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfEaK1B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 06:27:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbfEaK1A (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 31 May 2019 06:27:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4F06AF18;
        Fri, 31 May 2019 10:26:57 +0000 (UTC)
Subject: Re: [PATCH RFC] hisi_sas_v3: multiqueue support
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Ming Lei <tom.leiming@gmail.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
References: <20190531074158.76923-1-hare@suse.de>
 <20190531082116.GA12106@ming.t460p>
 <e81ca95e-95af-1078-c523-701120dd4ca7@suse.de>
 <20190531084600.GB12106@ming.t460p>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 mQINBE6KyREBEACwRN6XKClPtxPiABx5GW+Yr1snfhjzExxkTYaINHsWHlsLg13kiemsS6o7
 qrc+XP8FmhcnCOts9e2jxZxtmpB652lxRB9jZE40mcSLvYLM7S6aH0WXKn8bOqpqOGJiY2bc
 6qz6rJuqkOx3YNuUgiAxjuoYauEl8dg4bzex3KGkGRuxzRlC8APjHlwmsr+ETxOLBfUoRNuE
 b4nUtaseMPkNDwM4L9+n9cxpGbdwX0XwKFhlQMbG3rWA3YqQYWj1erKIPpgpfM64hwsdk9zZ
 QO1krgfULH4poPQFpl2+yVeEMXtsSou915jn/51rBelXeLq+cjuK5+B/JZUXPnNDoxOG3j3V
 VSZxkxLJ8RO1YamqZZbVP6jhDQ/bLcAI3EfjVbxhw9KWrh8MxTcmyJPn3QMMEp3wpVX9nSOQ
 tzG72Up/Py67VQe0x8fqmu7R4MmddSbyqgHrab/Nu+ak6g2RRn3QHXAQ7PQUq55BDtj85hd9
 W2iBiROhkZ/R+Q14cJkWhzaThN1sZ1zsfBNW0Im8OVn/J8bQUaS0a/NhpXJWv6J1ttkX3S0c
 QUratRfX4D1viAwNgoS0Joq7xIQD+CfJTax7pPn9rT////hSqJYUoMXkEz5IcO+hptCH1HF3
 qz77aA5njEBQrDRlslUBkCZ5P+QvZgJDy0C3xRGdg6ZVXEXJOQARAQABtCpIYW5uZXMgUmVp
 bmVja2UgKFN1U0UgTGFicykgPGhhcmVAc3VzZS5kZT6JAkEEEwECACsCGwMFCRLMAwAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheABQJOisquAhkBAAoJEGz4yi9OyKjPOHoQAJLeLvr6JNHx
 GPcHXaJLHQiinz2QP0/wtsT8+hE26dLzxb7hgxLafj9XlAXOG3FhGd+ySlQ5wSbbjdxNjgsq
 FIjqQ88/Lk1NfnqG5aUTPmhEF+PzkPogEV7Pm5Q17ap22VK623MPaltEba+ly6/pGOODbKBH
 ak3gqa7Gro5YCQzNU0QVtMpWyeGF7xQK76DY/atvAtuVPBJHER+RPIF7iv5J3/GFIfdrM+wS
 BubFVDOibgM7UBnpa7aohZ9RgPkzJpzECsbmbttxYaiv8+EOwark4VjvOne8dRaj50qeyJH6
 HLpBXZDJH5ZcYJPMgunghSqghgfuUsd5fHmjFr3hDb5EoqAfgiRMSDom7wLZ9TGtT6viDldv
 hfWaIOD5UhpNYxfNgH6Y102gtMmN4o2P6g3UbZK1diH13s9DA5vI2mO2krGz2c5BOBmcctE5
 iS+JWiCizOqia5Op+B/tUNye/YIXSC4oMR++Fgt30OEafB8twxydMAE3HmY+foawCpGq06yM
 vAguLzvm7f6wAPesDAO9vxRNC5y7JeN4Kytl561ciTICmBR80Pdgs/Obj2DwM6dvHquQbQrU
 Op4XtD3eGUW4qgD99DrMXqCcSXX/uay9kOG+fQBfK39jkPKZEuEV2QdpE4Pry36SUGfohSNq
 xXW+bMc6P+irTT39VWFUJMcSuQINBE6KyREBEACvEJggkGC42huFAqJcOcLqnjK83t4TVwEn
 JRisbY/VdeZIHTGtcGLqsALDzk+bEAcZapguzfp7cySzvuR6Hyq7hKEjEHAZmI/3IDc9nbdh
 EgdCiFatah0XZ/p4vp7KAelYqbv8YF/ORLylAdLh9rzLR6yHFqVaR4WL4pl4kEWwFhNSHLxe
 55G56/dxBuoj4RrFoX3ynerXfbp4dH2KArPc0NfoamqebuGNfEQmDbtnCGE5zKcR0zvmXsRp
 qU7+caufueZyLwjTU+y5p34U4PlOO2Q7/bdaPEdXfpgvSpWk1o3H36LvkPV/PGGDCLzaNn04
 BdiiiPEHwoIjCXOAcR+4+eqM4TSwVpTn6SNgbHLjAhCwCDyggK+3qEGJph+WNtNU7uFfscSP
 k4jqlxc8P+hn9IqaMWaeX9nBEaiKffR7OKjMdtFFnBRSXiW/kOKuuRdeDjL5gWJjY+IpdafP
 KhjvUFtfSwGdrDUh3SvB5knSixE3qbxbhbNxmqDVzyzMwunFANujyyVizS31DnWC6tKzANkC
 k15CyeFC6sFFu+WpRxvC6fzQTLI5CRGAB6FAxz8Hu5rpNNZHsbYs9Vfr/BJuSUfRI/12eOCL
 IvxRPpmMOlcI4WDW3EDkzqNAXn5Onx/b0rFGFpM4GmSPriEJdBb4M4pSD6fN6Y/Jrng/Bdwk
 SQARAQABiQIlBBgBAgAPBQJOiskRAhsMBQkSzAMAAAoJEGz4yi9OyKjPgEwQAIP/gy/Xqc1q
 OpzfFScswk3CEoZWSqHxn/fZasa4IzkwhTUmukuIvRew+BzwvrTxhHcz9qQ8hX7iDPTZBcUt
 ovWPxz+3XfbGqE+q0JunlIsP4N+K/I10nyoGdoFpMFMfDnAiMUiUatHRf9Wsif/nT6oRiPNJ
 T0EbbeSyIYe+ZOMFfZBVGPqBCbe8YMI+JiZeez8L9JtegxQ6O3EMQ//1eoPJ5mv5lWXLFQfx
 f4rAcKseM8DE6xs1+1AIsSIG6H+EE3tVm+GdCkBaVAZo2VMVapx9k8RMSlW7vlGEQsHtI0FT
 c1XNOCGjaP4ITYUiOpfkh+N0nUZVRTxWnJqVPGZ2Nt7xCk7eoJWTSMWmodFlsKSgfblXVfdM
 9qoNScM3u0b9iYYuw/ijZ7VtYXFuQdh0XMM/V6zFrLnnhNmg0pnK6hO1LUgZlrxHwLZk5X8F
 uD/0MCbPmsYUMHPuJd5dSLUFTlejVXIbKTSAMd0tDSP5Ms8Ds84z5eHreiy1ijatqRFWFJRp
 ZtWlhGRERnDH17PUXDglsOA08HCls0PHx8itYsjYCAyETlxlLApXWdVl9YVwbQpQ+i693t/Y
 PGu8jotn0++P19d3JwXW8t6TVvBIQ1dRZHx1IxGLMn+CkDJMOmHAUMWTAXX2rf5tUjas8/v2
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <f7e184d4-3d90-2c36-84b8-702105dccafb@suse.de>
Date:   Fri, 31 May 2019 12:26:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531084600.GB12106@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/31/19 10:46 AM, Ming Lei wrote:
> On Fri, May 31, 2019 at 10:32:04AM +0200, Hannes Reinecke wrote:
>> On 5/31/19 10:21 AM, Ming Lei wrote:
>>> On Fri, May 31, 2019 at 09:41:58AM +0200, Hannes Reinecke wrote:
>>>> (Resending due to missing mailing list submission)
>>>>
>>>> Update v3 to support SCSI multiqueue.
>>>>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.com>
>>>> ---
>>>>  drivers/scsi/hisi_sas/hisi_sas.h       |  1 -
>>>>  drivers/scsi/hisi_sas/hisi_sas_main.c  | 45 +++++++++++++++++-----------------
>>>>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 44 +++++++++++----------------------
>>>>  3 files changed, 36 insertions(+), 54 deletions(-)
>>>>
>>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
>>>> index fc87994b5d73..4b6f32f60689 100644
>>>> --- a/drivers/scsi/hisi_sas/hisi_sas.h
>>>> +++ b/drivers/scsi/hisi_sas/hisi_sas.h
>>>> @@ -378,7 +378,6 @@ struct hisi_hba {
>>>>  	u32 intr_coal_count;	/* Interrupt count to coalesce */
>>>>  
>>>>  	int cq_nvecs;
>>>> -	unsigned int *reply_map;
>>>>  
>>>>  	/* debugfs memories */
>>>>  	u32 *debugfs_global_reg;
>>>> diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>>> index 8a7feb8ed8d6..f4237c4754a4 100644
>>>> --- a/drivers/scsi/hisi_sas/hisi_sas_main.c
>>>> +++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
>>>> @@ -200,16 +200,12 @@ static void hisi_sas_slot_index_set(struct hisi_hba *hisi_hba, int slot_idx)
>>>>  	set_bit(slot_idx, bitmap);
>>>>  }
>>>>  
>>>> -static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba,
>>>> -				     struct scsi_cmnd *scsi_cmnd)
>>>> +static int hisi_sas_slot_index_alloc(struct hisi_hba *hisi_hba)
>>>>  {
>>>>  	int index;
>>>>  	void *bitmap = hisi_hba->slot_index_tags;
>>>>  	unsigned long flags;
>>>>  
>>>> -	if (scsi_cmnd)
>>>> -		return scsi_cmnd->request->tag;
>>>> -
>>>>  	spin_lock_irqsave(&hisi_hba->lock, flags);
>>>>  	index = find_next_zero_bit(bitmap, hisi_hba->slot_index_count,
>>>>  				   hisi_hba->last_slot_index + 1);
>>>
>>> Then you switch to hisi_sas_slot_index_alloc() for allocating the unique
>>> tag via spin_lock & find_next_zero_bit(). Do you think this way is more
>>> efficient than blk-mq's sbitmap?
>>>
>> slot_index_alloc() is only used for commands which do _not_ have a tag
>> (eg internal commands), or for v2 hardware which has weird allocation rules.
> 
> But this patch has switched to this allocation unconditionally for all commands:
> 
No:

@@ -503,21 +513,10 @@ static int hisi_sas_task_prep(struct sas_task *task,

        if (hisi_hba->hw->slot_index_alloc)
                rc = hisi_hba->hw->slot_index_alloc(hisi_hba, device);
-       else {
-               struct scsi_cmnd *scsi_cmnd = NULL;
-
-               if (task->uldd_task) {
-                       struct ata_queued_cmd *qc;
-
-                       if (dev_is_sata(device)) {
-                               qc = task->uldd_task;
-                               scsi_cmnd = qc->scsicmd;
-                       } else {
-                               scsi_cmnd = task->uldd_task;
-                       }
-               }
-               rc  = hisi_sas_slot_index_alloc(hisi_hba, scsi_cmnd);
-       }
+       else if (blk_tag != (u32)-1)
+               rc = blk_mq_unique_tag_to_tag(blk_tag);
+       else
+               rc  = hisi_sas_slot_index_alloc(hisi_hba);
        if (rc < 0)
                goto err_out_dif_dma_unmap;


First we check for the 'slot_index_alloc()' callback to handle weird v2
allocation rules, _then_ we look for a tag, and only if we do _not_ have
a tag we're using the bitmap.
And the bitmap is already correctly sized, as otherwise we'd have a
clash between internal and tagged I/O commands even now.

>> -       if (scsi_cmnd)
>> -               return scsi_cmnd->request->tag;
>> -
> 
> Otherwise duplicated slot can be used from different blk-mq hw queue.
> 
>>
>>> The worsen thing is that V3's actual max queue depth is (4096 - 96), but
>>> this patch claims that the device can support (4096 - 96) * 32 command
>>> slots, finally hisi_sas_slot_index_alloc() is used to respect the actual
>>> max queue depth(4000).
>>>
>> Well, this patch is an RFC to demonstrate my idea. Of course the queue
>> depth should be identical before and after the conversion.
> 
> That is why I call it is hard to partition the hostwide tags to MQ.
> 
It's not. The driver already sets aside a portion of tags for internal
commands (check HISI_SAS_RESERVED_IPTT_CNT), so it is already
effectively partitioned.

>>
>>> Big contention is caused on hisi_sas_slot_index_alloc(), meantime huge> memory is wasted for request pool.
>>>
>> See above. That allocation is only used if no blk tag is available.
> 
> This patch switches the allocation for all commands.
> 
See above. No.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
