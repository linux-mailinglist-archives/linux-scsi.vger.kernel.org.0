Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855814AEC98
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Feb 2022 09:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbiBIIgS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Feb 2022 03:36:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242550AbiBIIgP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Feb 2022 03:36:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65227C05CBA7
        for <linux-scsi@vger.kernel.org>; Wed,  9 Feb 2022 00:36:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EA751F383;
        Wed,  9 Feb 2022 08:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644395776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d35YeDqdqSXEfIsK0vOdVIy2re55zB1PfQuTUy7m2OQ=;
        b=nTomQd4LU9j5hcj+aRaU4ohpXtv2X5LjIt0CnhVl5qjCf2clQTe1lbgM+f4Mg8aqVFV81a
        hdZM0YH6JQs1Kx510xCxGQA/a5InSIX3sJsrqyUf3phnRIiYpLKBkhb1bajpcmSO1VjIpY
        80UAB3CNb2NvpQzxZg9YG29BoPS2w04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644395776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d35YeDqdqSXEfIsK0vOdVIy2re55zB1PfQuTUy7m2OQ=;
        b=VoXGtu7AajOMA3He85sA/4APGSmEFt5qbIpANNLsnukR04nS8xUyFK0sxPEGKFd96/7yYK
        +OgI/cqK1M1voSAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0C2813A7C;
        Wed,  9 Feb 2022 08:36:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XYQZNP98A2JLKAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 09 Feb 2022 08:36:15 +0000
Message-ID: <69d3cbbf-a1c9-8d52-ab51-c9eca19c36aa@suse.de>
Date:   Wed, 9 Feb 2022 09:36:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 42/44] wdc33c93: Move the SCSI pointer to private
 command data
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20220208172514.3481-1-bvanassche@acm.org>
 <20220208172514.3481-43-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220208172514.3481-43-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2/8/22 18:25, Bart Van Assche wrote:
> Set .cmd_size in the SCSI host template instead of using the SCSI pointer
> from struct scsi_cmnd. This patch prepares for removal of the SCSI pointer
> from struct scsi_cmnd.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/scsi/a2091.c   |  19 ++++---
>   drivers/scsi/a3000.c   |  19 ++++---
>   drivers/scsi/gvp11.c   |  19 ++++---
>   drivers/scsi/mvme147.c |  10 ++--
>   drivers/scsi/sgiwd93.c |  18 ++++---
>   drivers/scsi/wd33c93.c | 119 ++++++++++++++++++++++-------------------
>   drivers/scsi/wd33c93.h |  10 ++++
>   7 files changed, 123 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/scsi/a2091.c b/drivers/scsi/a2091.c
> index bcbce23478b8..c619c834abd0 100644
> --- a/drivers/scsi/a2091.c
> +++ b/drivers/scsi/a2091.c
> @@ -44,16 +44,17 @@ static irqreturn_t a2091_intr(int irq, void *data)
>   
>   static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   {
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(cmd);
>   	struct Scsi_Host *instance = cmd->device->host;
>   	struct a2091_hostdata *hdata = shost_priv(instance);
>   	struct WD33C93_hostdata *wh = &hdata->wh;
>   	struct a2091_scsiregs *regs = hdata->regs;
>   	unsigned short cntr = CNTR_PDMD | CNTR_INTEN;
> -	unsigned long addr = virt_to_bus(cmd->SCp.ptr);
> +	unsigned long addr = virt_to_bus(scsi_pointer->ptr);
>   
>   	/* don't allow DMA if the physical address is bad */
>   	if (addr & A2091_XFER_MASK) {
> -		wh->dma_bounce_len = (cmd->SCp.this_residual + 511) & ~0x1ff;
> +		wh->dma_bounce_len = (scsi_pointer->this_residual + 511) & ~0x1ff;
>   		wh->dma_bounce_buffer = kmalloc(wh->dma_bounce_len,
>   						GFP_KERNEL);
>   
> @@ -77,8 +78,8 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   
>   		if (!dir_in) {
>   			/* copy to bounce buffer for a write */
> -			memcpy(wh->dma_bounce_buffer, cmd->SCp.ptr,
> -			       cmd->SCp.this_residual);
> +			memcpy(wh->dma_bounce_buffer, scsi_pointer->ptr,
> +			       scsi_pointer->this_residual);
>   		}
>   	}
>   
> @@ -96,10 +97,10 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   
>   	if (dir_in) {
>   		/* invalidate any cache */
> -		cache_clear(addr, cmd->SCp.this_residual);
> +		cache_clear(addr, scsi_pointer->this_residual);
>   	} else {
>   		/* push any dirty cache */
> -		cache_push(addr, cmd->SCp.this_residual);
> +		cache_push(addr, scsi_pointer->this_residual);
>   	}
>   	/* start DMA */
>   	regs->ST_DMA = 1;
> @@ -111,6 +112,7 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
>   		     int status)
>   {
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(SCpnt);
>   	struct a2091_hostdata *hdata = shost_priv(instance);
>   	struct WD33C93_hostdata *wh = &hdata->wh;
>   	struct a2091_scsiregs *regs = hdata->regs;
> @@ -143,8 +145,8 @@ static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
>   	/* copy from a bounce buffer, if necessary */
>   	if (status && wh->dma_bounce_buffer) {
>   		if (wh->dma_dir)
> -			memcpy(SCpnt->SCp.ptr, wh->dma_bounce_buffer,
> -			       SCpnt->SCp.this_residual);
> +			memcpy(scsi_pointer->ptr, wh->dma_bounce_buffer,
> +			       scsi_pointer->this_residual);
>   		kfree(wh->dma_bounce_buffer);
>   		wh->dma_bounce_buffer = NULL;
>   		wh->dma_bounce_len = 0;
> @@ -165,6 +167,7 @@ static struct scsi_host_template a2091_scsi_template = {
>   	.sg_tablesize		= SG_ALL,
>   	.cmd_per_lun		= CMD_PER_LUN,
>   	.dma_boundary		= PAGE_SIZE - 1,
> +	.cmd_size		= sizeof(struct WD33C93_cmd),
>   };
>   
>   static int a2091_probe(struct zorro_dev *z, const struct zorro_device_id *ent)
> diff --git a/drivers/scsi/a3000.c b/drivers/scsi/a3000.c
> index 23f34411f7bf..1906c695ee4a 100644
> --- a/drivers/scsi/a3000.c
> +++ b/drivers/scsi/a3000.c
> @@ -48,12 +48,13 @@ static irqreturn_t a3000_intr(int irq, void *data)
>   
>   static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   {
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(cmd);
>   	struct Scsi_Host *instance = cmd->device->host;
>   	struct a3000_hostdata *hdata = shost_priv(instance);
>   	struct WD33C93_hostdata *wh = &hdata->wh;
>   	struct a3000_scsiregs *regs = hdata->regs;
>   	unsigned short cntr = CNTR_PDMD | CNTR_INTEN;
> -	unsigned long addr = virt_to_bus(cmd->SCp.ptr);
> +	unsigned long addr = virt_to_bus(scsi_pointer->ptr);
>   
>   	/*
>   	 * if the physical address has the wrong alignment, or if
> @@ -62,7 +63,7 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   	 * buffer
>   	 */
>   	if (addr & A3000_XFER_MASK) {
> -		wh->dma_bounce_len = (cmd->SCp.this_residual + 511) & ~0x1ff;
> +		wh->dma_bounce_len = (scsi_pointer->this_residual + 511) & ~0x1ff;
>   		wh->dma_bounce_buffer = kmalloc(wh->dma_bounce_len,
>   						GFP_KERNEL);
>   
> @@ -74,8 +75,8 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   
>   		if (!dir_in) {
>   			/* copy to bounce buffer for a write */
> -			memcpy(wh->dma_bounce_buffer, cmd->SCp.ptr,
> -			       cmd->SCp.this_residual);
> +			memcpy(wh->dma_bounce_buffer, scsi_pointer->ptr,
> +			       scsi_pointer->this_residual);
>   		}
>   
>   		addr = virt_to_bus(wh->dma_bounce_buffer);
> @@ -95,10 +96,10 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   
>   	if (dir_in) {
>   		/* invalidate any cache */
> -		cache_clear(addr, cmd->SCp.this_residual);
> +		cache_clear(addr, scsi_pointer->this_residual);
>   	} else {
>   		/* push any dirty cache */
> -		cache_push(addr, cmd->SCp.this_residual);
> +		cache_push(addr, scsi_pointer->this_residual);
>   	}
>   
>   	/* start DMA */
> @@ -113,6 +114,7 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
>   		     int status)
>   {
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(SCpnt);
>   	struct a3000_hostdata *hdata = shost_priv(instance);
>   	struct WD33C93_hostdata *wh = &hdata->wh;
>   	struct a3000_scsiregs *regs = hdata->regs;
> @@ -153,8 +155,8 @@ static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
>   	if (status && wh->dma_bounce_buffer) {
>   		if (SCpnt) {
>   			if (wh->dma_dir && SCpnt)
> -				memcpy(SCpnt->SCp.ptr, wh->dma_bounce_buffer,
> -				       SCpnt->SCp.this_residual);
> +				memcpy(scsi_pointer->ptr, wh->dma_bounce_buffer,
> +				       scsi_pointer->this_residual);
>   			kfree(wh->dma_bounce_buffer);
>   			wh->dma_bounce_buffer = NULL;
>   			wh->dma_bounce_len = 0;
> @@ -179,6 +181,7 @@ static struct scsi_host_template amiga_a3000_scsi_template = {
>   	.this_id		= 7,
>   	.sg_tablesize		= SG_ALL,
>   	.cmd_per_lun		= CMD_PER_LUN,
> +	.cmd_size		= sizeof(struct WD33C93_cmd),
>   };
>   
>   static int __init amiga_a3000_scsi_probe(struct platform_device *pdev)
> diff --git a/drivers/scsi/gvp11.c b/drivers/scsi/gvp11.c
> index 43754c2f36b3..c990b82451dd 100644
> --- a/drivers/scsi/gvp11.c
> +++ b/drivers/scsi/gvp11.c
> @@ -53,18 +53,19 @@ void gvp11_setup(char *str, int *ints)
>   
>   static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   {
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(cmd);
>   	struct Scsi_Host *instance = cmd->device->host;
>   	struct gvp11_hostdata *hdata = shost_priv(instance);
>   	struct WD33C93_hostdata *wh = &hdata->wh;
>   	struct gvp11_scsiregs *regs = hdata->regs;
>   	unsigned short cntr = GVP11_DMAC_INT_ENABLE;
> -	unsigned long addr = virt_to_bus(cmd->SCp.ptr);
> +	unsigned long addr = virt_to_bus(scsi_pointer->ptr);
>   	int bank_mask;
>   	static int scsi_alloc_out_of_range = 0;
>   
>   	/* use bounce buffer if the physical address is bad */
>   	if (addr & wh->dma_xfer_mask) {
> -		wh->dma_bounce_len = (cmd->SCp.this_residual + 511) & ~0x1ff;
> +		wh->dma_bounce_len = (scsi_pointer->this_residual + 511) & ~0x1ff;
>   
>   		if (!scsi_alloc_out_of_range) {
>   			wh->dma_bounce_buffer =
> @@ -113,8 +114,8 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   
>   		if (!dir_in) {
>   			/* copy to bounce buffer for a write */
> -			memcpy(wh->dma_bounce_buffer, cmd->SCp.ptr,
> -			       cmd->SCp.this_residual);
> +			memcpy(wh->dma_bounce_buffer, scsi_pointer->ptr,
> +			       scsi_pointer->this_residual);
>   		}
>   	}
>   
> @@ -130,10 +131,10 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   
>   	if (dir_in) {
>   		/* invalidate any cache */
> -		cache_clear(addr, cmd->SCp.this_residual);
> +		cache_clear(addr, scsi_pointer->this_residual);
>   	} else {
>   		/* push any dirty cache */
> -		cache_push(addr, cmd->SCp.this_residual);
> +		cache_push(addr, scsi_pointer->this_residual);
>   	}
>   
>   	bank_mask = (~wh->dma_xfer_mask >> 18) & 0x01c0;
> @@ -150,6 +151,7 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
>   		     int status)
>   {
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(SCpnt);
>   	struct gvp11_hostdata *hdata = shost_priv(instance);
>   	struct WD33C93_hostdata *wh = &hdata->wh;
>   	struct gvp11_scsiregs *regs = hdata->regs;
> @@ -162,8 +164,8 @@ static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
>   	/* copy from a bounce buffer, if necessary */
>   	if (status && wh->dma_bounce_buffer) {
>   		if (wh->dma_dir && SCpnt)
> -			memcpy(SCpnt->SCp.ptr, wh->dma_bounce_buffer,
> -			       SCpnt->SCp.this_residual);
> +			memcpy(scsi_pointer->ptr, wh->dma_bounce_buffer,
> +			       scsi_pointer->this_residual);
>   
>   		if (wh->dma_buffer_pool == BUF_SCSI_ALLOCED)
>   			kfree(wh->dma_bounce_buffer);
> @@ -189,6 +191,7 @@ static struct scsi_host_template gvp11_scsi_template = {
>   	.sg_tablesize		= SG_ALL,
>   	.cmd_per_lun		= CMD_PER_LUN,
>   	.dma_boundary		= PAGE_SIZE - 1,
> +	.cmd_size		= sizeof(struct WD33C93_cmd),
>   };
>   
>   static int check_wd33c93(struct gvp11_scsiregs *regs)
> diff --git a/drivers/scsi/mvme147.c b/drivers/scsi/mvme147.c
> index 0893d4c3a916..28d73e6a99be 100644
> --- a/drivers/scsi/mvme147.c
> +++ b/drivers/scsi/mvme147.c
> @@ -33,10 +33,11 @@ static irqreturn_t mvme147_intr(int irq, void *data)
>   
>   static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   {
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(cmd);
>   	struct Scsi_Host *instance = cmd->device->host;
>   	struct WD33C93_hostdata *hdata = shost_priv(instance);
>   	unsigned char flags = 0x01;
> -	unsigned long addr = virt_to_bus(cmd->SCp.ptr);
> +	unsigned long addr = virt_to_bus(scsi_pointer->ptr);
>   
>   	/* setup dma direction */
>   	if (!dir_in)
> @@ -47,14 +48,14 @@ static int dma_setup(struct scsi_cmnd *cmd, int dir_in)
>   
>   	if (dir_in) {
>   		/* invalidate any cache */
> -		cache_clear(addr, cmd->SCp.this_residual);
> +		cache_clear(addr, scsi_pointer->this_residual);
>   	} else {
>   		/* push any dirty cache */
> -		cache_push(addr, cmd->SCp.this_residual);
> +		cache_push(addr, scsi_pointer->this_residual);
>   	}
>   
>   	/* start DMA */
> -	m147_pcc->dma_bcr = cmd->SCp.this_residual | (1 << 24);
> +	m147_pcc->dma_bcr = scsi_pointer->this_residual | (1 << 24);
>   	m147_pcc->dma_dadr = addr;
>   	m147_pcc->dma_cntrl = flags;
>   
> @@ -81,6 +82,7 @@ static struct scsi_host_template mvme147_host_template = {
>   	.this_id		= 7,
>   	.sg_tablesize		= SG_ALL,
>   	.cmd_per_lun		= CMD_PER_LUN,
> +	.cmd_size		= sizeof(struct WD33C93_cmd),
>   };
>   
>   static struct Scsi_Host *mvme147_shost;
> diff --git a/drivers/scsi/sgiwd93.c b/drivers/scsi/sgiwd93.c
> index e797d89c873b..c519c7fa9c3c 100644
> --- a/drivers/scsi/sgiwd93.c
> +++ b/drivers/scsi/sgiwd93.c
> @@ -69,14 +69,15 @@ static irqreturn_t sgiwd93_intr(int irq, void *dev_id)
>   static inline
>   void fill_hpc_entries(struct ip22_hostdata *hd, struct scsi_cmnd *cmd, int din)
>   {
> -	unsigned long len = cmd->SCp.this_residual;
> -	void *addr = cmd->SCp.ptr;
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(cmd);
> +	unsigned long len = scsi_pointer->this_residual;
> +	void *addr = scsi_pointer->ptr;
>   	dma_addr_t physaddr;
>   	unsigned long count;
>   	struct hpc_chunk *hcp;
>   
>   	physaddr = dma_map_single(hd->dev, addr, len, DMA_DIR(din));
> -	cmd->SCp.dma_handle = physaddr;
> +	scsi_pointer->dma_handle = physaddr;
>   	hcp = hd->cpu;
>   
>   	while (len) {
> @@ -106,6 +107,7 @@ void fill_hpc_entries(struct ip22_hostdata *hd, struct scsi_cmnd *cmd, int din)
>   
>   static int dma_setup(struct scsi_cmnd *cmd, int datainp)
>   {
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(cmd);
>   	struct ip22_hostdata *hdata = host_to_hostdata(cmd->device->host);
>   	struct hpc3_scsiregs *hregs =
>   		(struct hpc3_scsiregs *) cmd->device->host->base;
> @@ -120,7 +122,7 @@ static int dma_setup(struct scsi_cmnd *cmd, int datainp)
>   	 * obvious).  IMHO a better fix would be, not to do these dma setups
>   	 * in the first place.
>   	 */
> -	if (cmd->SCp.ptr == NULL || cmd->SCp.this_residual == 0)
> +	if (scsi_pointer->ptr == NULL || scsi_pointer->this_residual == 0)
>   		return 1;
>   
>   	fill_hpc_entries(hdata, cmd, datainp);
> @@ -140,13 +142,14 @@ static int dma_setup(struct scsi_cmnd *cmd, int datainp)
>   static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
>   		     int status)
>   {
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(SCpnt);
>   	struct ip22_hostdata *hdata = host_to_hostdata(instance);
>   	struct hpc3_scsiregs *hregs;
>   
>   	if (!SCpnt)
>   		return;
>   
> -	if (SCpnt->SCp.ptr == NULL || SCpnt->SCp.this_residual == 0)
> +	if (scsi_pointer->ptr == NULL || scsi_pointer->this_residual == 0)
>   		return;
>   
>   	hregs = (struct hpc3_scsiregs *) SCpnt->device->host->base;
> @@ -160,8 +163,8 @@ static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
>   			barrier();
>   	}
>   	hregs->ctrl = 0;
> -	dma_unmap_single(hdata->dev, SCpnt->SCp.dma_handle,
> -			 SCpnt->SCp.this_residual,
> +	dma_unmap_single(hdata->dev, scsi_pointer->dma_handle,
> +			 scsi_pointer->this_residual,
>   			 DMA_DIR(hdata->wh.dma_dir));
>   
>   	pr_debug("\n");
> @@ -213,6 +216,7 @@ static struct scsi_host_template sgiwd93_template = {
>   	.sg_tablesize		= SG_ALL,
>   	.cmd_per_lun		= 8,
>   	.dma_boundary		= PAGE_SIZE - 1,
> +	.cmd_size		= sizeof(struct WD33C93_cmd),
>   };
>   
>   static int sgiwd93_probe(struct platform_device *pdev)
> diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
> index 7d2f00f3571a..3fe562047d85 100644
> --- a/drivers/scsi/wd33c93.c
> +++ b/drivers/scsi/wd33c93.c
> @@ -364,6 +364,7 @@ calc_sync_msg(unsigned int period, unsigned int offset, unsigned int fast,
>   
>   static int wd33c93_queuecommand_lck(struct scsi_cmnd *cmd)
>   {
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(cmd);
>   	struct WD33C93_hostdata *hostdata;
>   	struct scsi_cmnd *tmp;
>   
> @@ -395,15 +396,15 @@ static int wd33c93_queuecommand_lck(struct scsi_cmnd *cmd)
>    */
>   
>   	if (scsi_bufflen(cmd)) {
> -		cmd->SCp.buffer = scsi_sglist(cmd);
> -		cmd->SCp.buffers_residual = scsi_sg_count(cmd) - 1;
> -		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
> -		cmd->SCp.this_residual = cmd->SCp.buffer->length;
> +		scsi_pointer->buffer = scsi_sglist(cmd);
> +		scsi_pointer->buffers_residual = scsi_sg_count(cmd) - 1;
> +		scsi_pointer->ptr = sg_virt(scsi_pointer->buffer);
> +		scsi_pointer->this_residual = scsi_pointer->buffer->length;
>   	} else {
> -		cmd->SCp.buffer = NULL;
> -		cmd->SCp.buffers_residual = 0;
> -		cmd->SCp.ptr = NULL;
> -		cmd->SCp.this_residual = 0;
> +		scsi_pointer->buffer = NULL;
> +		scsi_pointer->buffers_residual = 0;
> +		scsi_pointer->ptr = NULL;
> +		scsi_pointer->this_residual = 0;
>   	}
>   
>   /* WD docs state that at the conclusion of a "LEVEL2" command, the
> @@ -423,7 +424,7 @@ static int wd33c93_queuecommand_lck(struct scsi_cmnd *cmd)
>    * status byte is stored.
>    */
>   
> -	cmd->SCp.Status = ILLEGAL_STATUS_BYTE;
> +	scsi_pointer->Status = ILLEGAL_STATUS_BYTE;
>   
>   	/*
>   	 * Add the cmd to the end of 'input_Q'. Note that REQUEST SENSE
> @@ -470,6 +471,7 @@ DEF_SCSI_QCMD(wd33c93_queuecommand)
>   static void
>   wd33c93_execute(struct Scsi_Host *instance)
>   {
> +	struct scsi_pointer *scsi_pointer;
>   	struct WD33C93_hostdata *hostdata =
>   	    (struct WD33C93_hostdata *) instance->hostdata;
>   	const wd33c93_regs regs = hostdata->regs;
> @@ -546,7 +548,8 @@ wd33c93_execute(struct Scsi_Host *instance)
>    * to change around and experiment with for now.
>    */
>   
> -	cmd->SCp.phase = 0;	/* assume no disconnect */
> +	scsi_pointer = WD33C93_scsi_pointer(cmd);
> +	scsi_pointer->phase = 0;	/* assume no disconnect */
>   	if (hostdata->disconnect == DIS_NEVER)
>   		goto no;
>   	if (hostdata->disconnect == DIS_ALWAYS)
> @@ -563,7 +566,7 @@ wd33c93_execute(struct Scsi_Host *instance)
>   		    (prev->device->lun != cmd->device->lun)) {
>   			for (prev = (struct scsi_cmnd *) hostdata->input_Q; prev;
>   			     prev = (struct scsi_cmnd *) prev->host_scribble)
> -				prev->SCp.phase = 1;
> +				WD33C93_scsi_pointer(prev)->phase = 1;
>   			goto yes;
>   		}
>   	}
> @@ -571,7 +574,7 @@ wd33c93_execute(struct Scsi_Host *instance)
>   	goto no;
>   
>    yes:
> -	cmd->SCp.phase = 1;
> +	scsi_pointer->phase = 1;
>   
>   #ifdef PROC_STATISTICS
>   	hostdata->disc_allowed_cnt[cmd->device->id]++;
> @@ -579,7 +582,7 @@ wd33c93_execute(struct Scsi_Host *instance)
>   
>    no:
>   
> -	write_wd33c93(regs, WD_SOURCE_ID, ((cmd->SCp.phase) ? SRCID_ER : 0));
> +	write_wd33c93(regs, WD_SOURCE_ID, scsi_pointer->phase ? SRCID_ER : 0);
>   
>   	write_wd33c93(regs, WD_TARGET_LUN, (u8)cmd->device->lun);
>   	write_wd33c93(regs, WD_SYNCHRONOUS_TRANSFER,
> @@ -648,14 +651,14 @@ wd33c93_execute(struct Scsi_Host *instance)
>   		 * up ahead of time.
>   		 */
>   
> -		if ((cmd->SCp.phase == 0) && (hostdata->no_dma == 0)) {
> +		if (scsi_pointer->phase == 0 && hostdata->no_dma == 0) {
>   			if (hostdata->dma_setup(cmd,
>   			    (cmd->sc_data_direction == DMA_TO_DEVICE) ?
>   			     DATA_OUT_DIR : DATA_IN_DIR))
>   				write_wd33c93_count(regs, 0);	/* guarantee a DATA_PHASE interrupt */
>   			else {
>   				write_wd33c93_count(regs,
> -						    cmd->SCp.this_residual);
> +						scsi_pointer->this_residual);
>   				write_wd33c93(regs, WD_CONTROL,
>   					      CTRL_IDI | CTRL_EDI | hostdata->dma_mode);
>   				hostdata->dma = D_DMA_RUNNING;
> @@ -675,7 +678,7 @@ wd33c93_execute(struct Scsi_Host *instance)
>   	 */
>   
>   	DB(DB_EXECUTE,
> -	   printk("%s)EX-2 ", (cmd->SCp.phase) ? "d:" : ""))
> +	   printk("%s)EX-2 ", scsi_pointer->phase ? "d:" : ""))
>   }
>   
>   static void
> @@ -717,6 +720,7 @@ static void
>   transfer_bytes(const wd33c93_regs regs, struct scsi_cmnd *cmd,
>   		int data_in_dir)
>   {
> +	struct scsi_pointer *scsi_pointer = WD33C93_scsi_pointer(cmd);
>   	struct WD33C93_hostdata *hostdata;
>   	unsigned long length;
>   
> @@ -730,13 +734,13 @@ transfer_bytes(const wd33c93_regs regs, struct scsi_cmnd *cmd,
>    * now we need to setup the next scatter-gather buffer as the
>    * source or destination for THIS transfer.
>    */
> -	if (!cmd->SCp.this_residual && cmd->SCp.buffers_residual) {
> -		cmd->SCp.buffer = sg_next(cmd->SCp.buffer);
> -		--cmd->SCp.buffers_residual;
> -		cmd->SCp.this_residual = cmd->SCp.buffer->length;
> -		cmd->SCp.ptr = sg_virt(cmd->SCp.buffer);
> +	if (!scsi_pointer->this_residual && scsi_pointer->buffers_residual) {
> +		scsi_pointer->buffer = sg_next(scsi_pointer->buffer);
> +		--scsi_pointer->buffers_residual;
> +		scsi_pointer->this_residual = scsi_pointer->buffer->length;
> +		scsi_pointer->ptr = sg_virt(scsi_pointer->buffer);
>   	}
> -	if (!cmd->SCp.this_residual) /* avoid bogus setups */
> +	if (!scsi_pointer->this_residual) /* avoid bogus setups */
>   		return;
>   
>   	write_wd33c93(regs, WD_SYNCHRONOUS_TRANSFER,
> @@ -750,11 +754,12 @@ transfer_bytes(const wd33c93_regs regs, struct scsi_cmnd *cmd,
>   #ifdef PROC_STATISTICS
>   		hostdata->pio_cnt++;
>   #endif
> -		transfer_pio(regs, (uchar *) cmd->SCp.ptr,
> -			     cmd->SCp.this_residual, data_in_dir, hostdata);
> -		length = cmd->SCp.this_residual;
> -		cmd->SCp.this_residual = read_wd33c93_count(regs);
> -		cmd->SCp.ptr += (length - cmd->SCp.this_residual);
> +		transfer_pio(regs, (uchar *) scsi_pointer->ptr,
> +			     scsi_pointer->this_residual, data_in_dir,
> +			     hostdata);
> +		length = scsi_pointer->this_residual;
> +		scsi_pointer->this_residual = read_wd33c93_count(regs);
> +		scsi_pointer->ptr += length - scsi_pointer->this_residual;
>   	}
>   
>   /* We are able to do DMA (in fact, the Amiga hardware is
> @@ -771,10 +776,10 @@ transfer_bytes(const wd33c93_regs regs, struct scsi_cmnd *cmd,
>   		hostdata->dma_cnt++;
>   #endif
>   		write_wd33c93(regs, WD_CONTROL, CTRL_IDI | CTRL_EDI | hostdata->dma_mode);
> -		write_wd33c93_count(regs, cmd->SCp.this_residual);
> +		write_wd33c93_count(regs, scsi_pointer->this_residual);
>   
>   		if ((hostdata->level2 >= L2_DATA) ||
> -		    (hostdata->level2 == L2_BASIC && cmd->SCp.phase == 0)) {
> +		    (hostdata->level2 == L2_BASIC && scsi_pointer->phase == 0)) {
>   			write_wd33c93(regs, WD_COMMAND_PHASE, 0x45);
>   			write_wd33c93_cmd(regs, WD_CMD_SEL_ATN_XFER);
>   			hostdata->state = S_RUNNING_LEVEL2;
> @@ -788,6 +793,7 @@ transfer_bytes(const wd33c93_regs regs, struct scsi_cmnd *cmd,
>   void
>   wd33c93_intr(struct Scsi_Host *instance)
>   {
> +	struct scsi_pointer *scsi_pointer;
>   	struct WD33C93_hostdata *hostdata =
>   	    (struct WD33C93_hostdata *) instance->hostdata;
>   	const wd33c93_regs regs = hostdata->regs;
> @@ -806,6 +812,7 @@ wd33c93_intr(struct Scsi_Host *instance)
>   #endif
>   
>   	cmd = (struct scsi_cmnd *) hostdata->connected;	/* assume we're connected */
> +	scsi_pointer = WD33C93_scsi_pointer(cmd);
>   	sr = read_wd33c93(regs, WD_SCSI_STATUS);	/* clear the interrupt */
>   	phs = read_wd33c93(regs, WD_COMMAND_PHASE);
>   
> @@ -827,14 +834,14 @@ wd33c93_intr(struct Scsi_Host *instance)
>    */
>   	    if (hostdata->dma == D_DMA_RUNNING) {
>   		DB(DB_TRANSFER,
> -		   printk("[%p/%d:", cmd->SCp.ptr, cmd->SCp.this_residual))
> +		   printk("[%p/%d:", scsi_pointer->ptr, scsi_pointer->this_residual))
>   		    hostdata->dma_stop(cmd->device->host, cmd, 1);
>   		hostdata->dma = D_DMA_OFF;
> -		length = cmd->SCp.this_residual;
> -		cmd->SCp.this_residual = read_wd33c93_count(regs);
> -		cmd->SCp.ptr += (length - cmd->SCp.this_residual);
> +		length = scsi_pointer->this_residual;
> +		scsi_pointer->this_residual = read_wd33c93_count(regs);
> +		scsi_pointer->ptr += length - scsi_pointer->this_residual;
>   		DB(DB_TRANSFER,
> -		   printk("%p/%d]", cmd->SCp.ptr, cmd->SCp.this_residual))
> +		   printk("%p/%d]", scsi_pointer->ptr, scsi_pointer->this_residual))
>   	}
>   
>   /* Respond to the specific WD3393 interrupt - there are quite a few! */
> @@ -884,7 +891,7 @@ wd33c93_intr(struct Scsi_Host *instance)
>   		/* construct an IDENTIFY message with correct disconnect bit */
>   
>   		hostdata->outgoing_msg[0] = IDENTIFY(0, cmd->device->lun);
> -		if (cmd->SCp.phase)
> +		if (scsi_pointer->phase)
>   			hostdata->outgoing_msg[0] |= 0x40;
>   
>   		if (hostdata->sync_stat[cmd->device->id] == SS_FIRST) {
> @@ -926,8 +933,8 @@ wd33c93_intr(struct Scsi_Host *instance)
>   	case CSR_UNEXP | PHS_DATA_IN:
>   	case CSR_SRV_REQ | PHS_DATA_IN:
>   		DB(DB_INTR,
> -		   printk("IN-%d.%d", cmd->SCp.this_residual,
> -			  cmd->SCp.buffers_residual))
> +		   printk("IN-%d.%d", scsi_pointer->this_residual,
> +			  scsi_pointer->buffers_residual))
>   		    transfer_bytes(regs, cmd, DATA_IN_DIR);
>   		if (hostdata->state != S_RUNNING_LEVEL2)
>   			hostdata->state = S_CONNECTED;
> @@ -938,8 +945,8 @@ wd33c93_intr(struct Scsi_Host *instance)
>   	case CSR_UNEXP | PHS_DATA_OUT:
>   	case CSR_SRV_REQ | PHS_DATA_OUT:
>   		DB(DB_INTR,
> -		   printk("OUT-%d.%d", cmd->SCp.this_residual,
> -			  cmd->SCp.buffers_residual))
> +		   printk("OUT-%d.%d", scsi_pointer->this_residual,
> +			  scsi_pointer->buffers_residual))
>   		    transfer_bytes(regs, cmd, DATA_OUT_DIR);
>   		if (hostdata->state != S_RUNNING_LEVEL2)
>   			hostdata->state = S_CONNECTED;
> @@ -962,8 +969,8 @@ wd33c93_intr(struct Scsi_Host *instance)
>   	case CSR_UNEXP | PHS_STATUS:
>   	case CSR_SRV_REQ | PHS_STATUS:
>   		DB(DB_INTR, printk("STATUS="))
> -		cmd->SCp.Status = read_1_byte(regs);
> -		DB(DB_INTR, printk("%02x", cmd->SCp.Status))
> +		scsi_pointer->Status = read_1_byte(regs);
> +		DB(DB_INTR, printk("%02x", scsi_pointer->Status))
>   		    if (hostdata->level2 >= L2_BASIC) {
>   			sr = read_wd33c93(regs, WD_SCSI_STATUS);	/* clear interrupt */
>   			udelay(7);
> @@ -991,7 +998,7 @@ wd33c93_intr(struct Scsi_Host *instance)
>   		else
>   			hostdata->incoming_ptr = 0;
>   
> -		cmd->SCp.Message = msg;
> +		scsi_pointer->Message = msg;
>   		switch (msg) {
>   
>   		case COMMAND_COMPLETE:
> @@ -1163,21 +1170,21 @@ wd33c93_intr(struct Scsi_Host *instance)
>   		write_wd33c93(regs, WD_SOURCE_ID, SRCID_ER);
>   		if (phs == 0x60) {
>   			DB(DB_INTR, printk("SX-DONE"))
> -			    cmd->SCp.Message = COMMAND_COMPLETE;
> +			    scsi_pointer->Message = COMMAND_COMPLETE;
>   			lun = read_wd33c93(regs, WD_TARGET_LUN);
> -			DB(DB_INTR, printk(":%d.%d", cmd->SCp.Status, lun))
> +			DB(DB_INTR, printk(":%d.%d", scsi_pointer->Status, lun))
>   			    hostdata->connected = NULL;
>   			hostdata->busy[cmd->device->id] &= ~(1 << (cmd->device->lun & 0xff));
>   			hostdata->state = S_UNCONNECTED;
> -			if (cmd->SCp.Status == ILLEGAL_STATUS_BYTE)
> -				cmd->SCp.Status = lun;
> +			if (scsi_pointer->Status == ILLEGAL_STATUS_BYTE)
> +				scsi_pointer->Status = lun;
>   			if (cmd->cmnd[0] == REQUEST_SENSE
> -			    && cmd->SCp.Status != SAM_STAT_GOOD) {
> +			    && scsi_pointer->Status != SAM_STAT_GOOD) {
>   				set_host_byte(cmd, DID_ERROR);
>   			} else {
>   				set_host_byte(cmd, DID_OK);
> -				scsi_msg_to_host_byte(cmd, cmd->SCp.Message);
> -				set_status_byte(cmd, cmd->SCp.Status);
> +				scsi_msg_to_host_byte(cmd, scsi_pointer->Message);
> +				set_status_byte(cmd, scsi_pointer->Status);
>   			}
>   			scsi_done(cmd);
>   
> @@ -1259,12 +1266,12 @@ wd33c93_intr(struct Scsi_Host *instance)
>   		hostdata->busy[cmd->device->id] &= ~(1 << (cmd->device->lun & 0xff));
>   		hostdata->state = S_UNCONNECTED;
>   		if (cmd->cmnd[0] == REQUEST_SENSE &&
> -		    cmd->SCp.Status != SAM_STAT_GOOD) {
> +		    scsi_pointer->Status != SAM_STAT_GOOD) {
>   			set_host_byte(cmd, DID_ERROR);
>   		} else {
>   			set_host_byte(cmd, DID_OK);
> -			scsi_msg_to_host_byte(cmd, cmd->SCp.Message);
> -			set_status_byte(cmd, cmd->SCp.Status);
> +			scsi_msg_to_host_byte(cmd, scsi_pointer->Message);
> +			set_status_byte(cmd, scsi_pointer->Status);
>   		}
>   		scsi_done(cmd);
>   
> @@ -1293,14 +1300,14 @@ wd33c93_intr(struct Scsi_Host *instance)
>   			hostdata->connected = NULL;
>   			hostdata->busy[cmd->device->id] &= ~(1 << (cmd->device->lun & 0xff));
>   			hostdata->state = S_UNCONNECTED;
> -			DB(DB_INTR, printk(":%d", cmd->SCp.Status))
> +			DB(DB_INTR, printk(":%d", scsi_pointer->Status))
>   			if (cmd->cmnd[0] == REQUEST_SENSE
> -			    && cmd->SCp.Status != SAM_STAT_GOOD) {
> +			    && scsi_pointer->Status != SAM_STAT_GOOD) {
>   				set_host_byte(cmd, DID_ERROR);
>   			} else {
>   				set_host_byte(cmd, DID_OK);
> -				scsi_msg_to_host_byte(cmd, cmd->SCp.Message);
> -				set_status_byte(cmd, cmd->SCp.Status);
> +				scsi_msg_to_host_byte(cmd, scsi_pointer->Message);
> +				set_status_byte(cmd, scsi_pointer->Status);
>   			}
>   			scsi_done(cmd);
>   			break;
> diff --git a/drivers/scsi/wd33c93.h b/drivers/scsi/wd33c93.h
> index 2edec34c5a42..b5d6842c6944 100644
> --- a/drivers/scsi/wd33c93.h
> +++ b/drivers/scsi/wd33c93.h
> @@ -262,6 +262,16 @@ struct WD33C93_hostdata {
>   #endif
>       };
>   
> +struct WD33C93_cmd {
> +	struct scsi_pointer scsi_pointer;
> +};
> +
> +static inline struct scsi_pointer *WD33C93_scsi_pointer(struct scsi_cmnd *cmd)
> +{
> +	struct WD33C93_cmd *wcmd = scsi_cmd_priv(cmd);
> +
> +	return &wcmd->scsi_pointer;
> +}
>   
>   /* defines for hostdata->chip */
>   
Please use 'struct scsi_pointer' directly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
