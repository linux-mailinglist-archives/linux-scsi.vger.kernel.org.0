Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5F2630E15
	for <lists+linux-scsi@lfdr.de>; Sat, 19 Nov 2022 11:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiKSKXh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 19 Nov 2022 05:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiKSKXd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 19 Nov 2022 05:23:33 -0500
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A31E1CD
        for <linux-scsi@vger.kernel.org>; Sat, 19 Nov 2022 02:23:29 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id wL0PovmdsCoWhwL0PornL6; Sat, 19 Nov 2022 11:23:27 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 19 Nov 2022 11:23:27 +0100
X-ME-IP: 86.243.100.34
Message-ID: <629bac45-32c2-9eac-6fed-f2f9e39d2740@wanadoo.fr>
Date:   Sat, 19 Nov 2022 11:23:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2][next] scsi: qla2xxx: Replace one-element array with
 DECLARE_FLEX_ARRAY() helper
Content-Language: fr
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <njavali@marvell.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1668814746.git.gustavoars@kernel.org>
 <faa40e6b31ecc9387ad1644bb1957aa53d7c682f.1668814746.git.gustavoars@kernel.org>
 <ef2881de-7843-97b5-8e0e-64c23ee168d8@wanadoo.fr> <Y3iaLCY68E6Stgrp@work>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Y3iaLCY68E6Stgrp@work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Le 19/11/2022 à 09:56, Gustavo A. R. Silva a écrit :
> On Sat, Nov 19, 2022 at 09:44:02AM +0100, Christophe JAILLET wrote:
>> Le 19/11/2022 à 00:47, Gustavo A. R. Silva a écrit :
>>> One-element arrays as fake flex arrays are deprecated and we are moving
>>> towards adopting C99 flexible-array members, instead. So, replace
>>> one-element array declaration in struct ct_sns_gpnft_rsp, which is
>>> ultimately being used inside a union:
>>>
>>> drivers/scsi/qla2xxx/qla_def.h:
>>> 3240 struct ct_sns_gpnft_pkt {
>>> 3241         union {
>>> 3242                 struct ct_sns_req req;
>>> 3243                 struct ct_sns_gpnft_rsp rsp;
>>> 3244         } p;
>>> 3245 };
>>>
>>> Important to mention is that doing a build before/after this patch results
>>> in no binary differences.
>>
>> Hi,
>>
>> even with the:
>>
>>>    		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
>>> -			((vha->hw->max_fibre_devices - 1) *
>>> +			(vha->hw->max_fibre_devices *
>>>    			    sizeof(struct ct_sns_gpn_ft_data));
>>
>> change ?
> 
> Yep; that change compensates for the removal of the 1 in the declaration
> of entries[].
> 
> The above piece of code is a common idiom to calculate the size for an
> allocation when a one-element array is involved. In the original code
> (vha->hw->max_fibre_devices - 1) compensates for the _extra_ size of one
> element of type struct ct_sns_gpn_ft_data in sizeof(struct ct_sns_gpnft_rsp).
> 

Yes, I do agree, that the code is equivalent. I was surprised that a 
compiler was smart enough to generate the same binary code.

With gcc 11.3.0 (x86_64), I do get some differences when I do:
    make drivers/scsi/qla2xxx/qla_gs.o
    objdump -D  drivers/scsi/qla2xxx/qla_gs.o > before.asm

    patch -p1 < patch.diff

    make drivers/scsi/qla2xxx/qla_gs.o
    objdump -D  drivers/scsi/qla2xxx/qla_gs.o > after.asm

    diff -u before.asm after.asm

Mostly some slight ordering of instruction changes, but the binary are 
not the same.

CJ

> --
> Gustavo
> 
>>
>> CJ
>>
>>>
>>> This help us make progress towards globally enabling
>>> -fstrict-flex-arrays=3 [1].
>>>
>>> Link: https://github.com/KSPP/linux/issues/245
>>> Link: https://github.com/KSPP/linux/issues/193
>>> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>>    drivers/scsi/qla2xxx/qla_def.h | 4 ++--
>>>    drivers/scsi/qla2xxx/qla_gs.c  | 2 +-
>>>    2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
>>> index a26a373be9da..1eea977ef426 100644
>>> --- a/drivers/scsi/qla2xxx/qla_def.h
>>> +++ b/drivers/scsi/qla2xxx/qla_def.h
>>> @@ -3151,12 +3151,12 @@ struct ct_sns_gpnft_rsp {
>>>    		uint8_t vendor_unique;
>>>    	};
>>>    	/* Assume the largest number of targets for the union */
>>> -	struct ct_sns_gpn_ft_data {
>>> +	DECLARE_FLEX_ARRAY(struct ct_sns_gpn_ft_data {
>>>    		u8 control_byte;
>>>    		u8 port_id[3];
>>>    		u32 reserved;
>>>    		u8 port_name[8];
>>> -	} entries[1];
>>> +	}, entries);
>>>    };
>>>    /* CT command response */
>>> diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
>>> index 64ab070b8716..69d3bc795f90 100644
>>> --- a/drivers/scsi/qla2xxx/qla_gs.c
>>> +++ b/drivers/scsi/qla2xxx/qla_gs.c
>>> @@ -4073,7 +4073,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
>>>    		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
>>>    		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
>>> -			((vha->hw->max_fibre_devices - 1) *
>>> +			(vha->hw->max_fibre_devices *
>>>    			    sizeof(struct ct_sns_gpn_ft_data));
>>>    		sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
>>
> 

