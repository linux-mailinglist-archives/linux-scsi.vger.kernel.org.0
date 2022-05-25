Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA58533A43
	for <lists+linux-scsi@lfdr.de>; Wed, 25 May 2022 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiEYJvg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 25 May 2022 05:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiEYJvf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 25 May 2022 05:51:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B63527153
        for <linux-scsi@vger.kernel.org>; Wed, 25 May 2022 02:51:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0CD84219C8;
        Wed, 25 May 2022 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653472290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EczfhZiJ7jF+981x+WlB4h4TursXHI8LLSKAzdsNwgU=;
        b=oX+H3ifVfPqLa6ImfX9p4uKHDr5NdxJDe7PRbXMvujUmbC9TXawjAaU9+SjyFa70PqAar7
        /N7ChjsKNxbaA9eL8hM6eAQlg+julm21vQhLkHYPo59BINe3jQ3p1lIKq8qrwjKanrHqBf
        dcIvGDL7sOarYid+jK/zh9NGM+25xaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653472290;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EczfhZiJ7jF+981x+WlB4h4TursXHI8LLSKAzdsNwgU=;
        b=TlJzezo98MHjitnm7bb5IwmumiA9ocmMqJeFfst4v0Wluw79rMm2/wbM1DtwcOrJJL3+1d
        mNFYuDs3UJIsx3Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9078B13487;
        Wed, 25 May 2022 09:51:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PC8oICH8jWK7XgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 25 May 2022 09:51:29 +0000
Message-ID: <0639fb0d-70e7-3ba0-a9e1-98572b55dc3f@suse.de>
Date:   Wed, 25 May 2022 11:51:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH REPOST] scsi: lpfc: Add support for ATTO Fibre Channel
 devices
Content-Language: en-US
To:     Bradley Grove <bradley.grove@gmail.com>, linux-scsi@vger.kernel.org
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        Bradley Grove <bgrove@attotech.com>,
        Jason Seba <jseba@attotech.com>
References: <20220524125621.47102-1-bgrove@attotech.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220524125621.47102-1-bgrove@attotech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/24/22 14:56, Bradley Grove wrote:
> Update pci_device_id table and generate reporting strings for ATTO
> Celerity and ThunderLink Fibre Channel devices.
> 
> Co-developed-by: Jason Seba <jseba@attotech.com>
> Signed-off-by: Jason Seba <jseba@attotech.com>
> Signed-off-by: Bradley Grove <bgrove@attotech.com>
> ---
>   drivers/scsi/lpfc/lpfc_hw.h   | 22 +++++++++
>   drivers/scsi/lpfc/lpfc_ids.h  | 30 ++++++++++++
>   drivers/scsi/lpfc/lpfc_init.c | 89 +++++++++++++++++++++++++++++++++++
>   3 files changed, 141 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
