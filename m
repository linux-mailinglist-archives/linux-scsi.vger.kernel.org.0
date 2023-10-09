Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942387BE211
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Oct 2023 16:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346526AbjJIOFL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 9 Oct 2023 10:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbjJIOFK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 9 Oct 2023 10:05:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB6194
        for <linux-scsi@vger.kernel.org>; Mon,  9 Oct 2023 07:05:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9EB601F390;
        Mon,  9 Oct 2023 14:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1696860308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cpdMMqNdAaqzHtjstvvfj0zsggT4vnBr/KShOyfrP4E=;
        b=IzxNZFghVot02bDIXv/07mpv2BcG22HyDzEDNnBGOtR6PPQaVYmYe2h7FjstSVDx2VLZrL
        ydfb/RWrSBnmcuZy0xRsw8tSsMedTr6XS+5FXm7BtxAWI5Klxl5tQxQ2yKk2T9YGcjwrvU
        XZk9RPFLarsck5QKzWuVZ6MGzIGds+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1696860308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cpdMMqNdAaqzHtjstvvfj0zsggT4vnBr/KShOyfrP4E=;
        b=No09r9W3gN6PFfGia3FZrHXjzlQr2P4M7gSfeH3pzjHQuqPQ9GcMfkF12d7RRhUxvIcI4s
        Lf2skDQM7htga4CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DCD913586;
        Mon,  9 Oct 2023 14:05:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NomfHZQIJGWUAQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 09 Oct 2023 14:05:08 +0000
Message-ID: <18e61efc-bb5f-47f7-91ca-ddce3c9d077c@suse.de>
Date:   Mon, 9 Oct 2023 16:05:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] scsi: Use Scsi_Host as argument for
 eh_host_reset_handler
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20231002155915.109359-1-hare@suse.de>
 <20231002155915.109359-2-hare@suse.de>
 <c7052e80-3602-469b-8095-ab0eb40e010a@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <c7052e80-3602-469b-8095-ab0eb40e010a@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/3/23 19:33, Bart Van Assche wrote:
> On 10/2/23 08:59, Hannes Reinecke wrote:
>> +    if ((hd = shost_priv(sh)) == NULL){
>> +        printk(KERN_ERR MYNAM ": host reset: Can't locate host!\n");
>>           return FAILED;
>>       }
> 
> In the above example and in multiple other cases formatting does not
> follow the kernel coding style. Please consider to run git clang-format
> HEAD^ on this patch. Otherwise this patch looks good to me.
> 
That is correct, but I'm merely following the existing indentation
within that driver.
Reformatting the driver to align with current linux standards would be
a different patch.

Cheers,

Hannes
