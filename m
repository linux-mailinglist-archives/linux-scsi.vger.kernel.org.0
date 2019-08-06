Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DFE82C62
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Aug 2019 09:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfHFHLv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Aug 2019 03:11:51 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35347 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731711AbfHFHLv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Aug 2019 03:11:51 -0400
Received: by mail-vk1-f193.google.com with SMTP id m17so17172618vkl.2
        for <linux-scsi@vger.kernel.org>; Tue, 06 Aug 2019 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8Ci/8H9wUX2m10wfVRVtTIcb057+1T5ctq2J+f6Y+w=;
        b=L4bV7RoJjNCz5iprmtYNV/GYfL8PvHtlYPWeKdPrNLD1WPNHQPSokIzRc9q0QuyP2x
         WTEdX4UNSTmIg3O1jFWfRPvWZxiMqrEuxNk/1lj4DyEhApWJm27fI4oJnnCSzx3Wh3aU
         Cdpi3YNAd5TKzlYoW4sdPGS0XAkrTRgjqkjuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8Ci/8H9wUX2m10wfVRVtTIcb057+1T5ctq2J+f6Y+w=;
        b=nSgj+7l4audtcbAYr9H0BfCyCn6cUiXqAwBPUK+GY1w/QAWMWTzU+AfHdrRl7wKgkg
         wiojB0h/XlSpNzIYr4LXBZSszyrjY1bYVbc45UrdUIz9nVy9XjsJudcAxgKPxDrPUVzW
         B8ze/ToLvkedBOIol+LPRvwUJ33NNDY1ONLHnToglzqJ8cyQDnuPlpzNwzFpJDufajLF
         8Aqrgbk3pATyo4n3MDLV9VSI3HeZw8SlqG7+jEEAcJh3X1FteIW2mibzdX10e4oxkWCw
         kp0iyvu4SmALceTUFiGpYNHWS4iHSJp3p0ZIibPTBgJKJgnXm8FvJsFSzAobyS/PwWv5
         nAuw==
X-Gm-Message-State: APjAAAXaTCwhPyljnrqMGpkGX34wqE7YIvPVyERey9jr1ZmW98xTI11V
        Hye3k9gfu22Ef60Zy3h8T72BB6O0Ha0WInUkTJ4YOQ==
X-Google-Smtp-Source: APXvYqzUbqSd2bMaWsSsiOkndLEKbbXAFec9haL6ZQufi/FgOn9IAPeJfXrOApEQgI56Y9cdOaAilurGG+b2JGKItk8=
X-Received: by 2002:a1f:8887:: with SMTP id k129mr621675vkd.3.1565075509481;
 Tue, 06 Aug 2019 00:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190726135540.48780-1-yuehaibing@huawei.com>
In-Reply-To: <20190726135540.48780-1-yuehaibing@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Tue, 6 Aug 2019 12:41:37 +0530
Message-ID: <CAL2rwxpw_vz14Fwq+HPTnVYzc9xCrgC7OpCBSGsurZsVKZEdfw@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: Make a bunch of functions static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Jul 26, 2019 at 7:26 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warnings:
>
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3369:1: warning: symbol 'complete_cmd_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3535:6: warning: symbol 'megasas_sync_irqs' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3554:1: warning: symbol 'megasas_complete_cmd_dpc_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3573:13: warning: symbol 'megasas_isr_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3604:1: warning: symbol 'build_mpt_mfi_pass_thru' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3661:40: warning: symbol 'build_mpt_cmd' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3688:1: warning: symbol 'megasas_issue_dcmd_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:3881:5: warning: symbol 'megasas_wait_for_outstanding_fusion' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:4005:6: warning: symbol 'megasas_refire_mgmt_cmd' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:4525:25: warning: symbol 'megasas_get_peer_instance' was not declared. Should it be static?
> drivers/scsi/megaraid/megaraid_sas_fusion.c:4825:7: warning: symbol 'megasas_fusion_crash_dump' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/scsi/megaraid/megaraid_sas_fusion.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index 120e3c4..10ef99e 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -3511,7 +3511,7 @@ megasas_complete_r1_command(struct megasas_instance *instance,
>   * @instance:                  Adapter soft state
>   * Completes all commands that is in reply descriptor queue
>   */
> -int
> +static int
>  complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
>                     struct megasas_irq_context *irq_context)
>  {
> @@ -3702,7 +3702,7 @@ static void megasas_enable_irq_poll(struct megasas_instance *instance)
>   * megasas_sync_irqs - Synchronizes all IRQs owned by adapter
>   * @instance:                  Adapter soft state
>   */
> -void megasas_sync_irqs(unsigned long instance_addr)
> +static void megasas_sync_irqs(unsigned long instance_addr)
>  {
>         u32 count, i;
>         struct megasas_instance *instance =
> @@ -3760,7 +3760,7 @@ int megasas_irqpoll(struct irq_poll *irqpoll, int budget)
>   *
>   * Tasklet to complete cmds
>   */
> -void
> +static void
>  megasas_complete_cmd_dpc_fusion(unsigned long instance_addr)
>  {
>         struct megasas_instance *instance =
> @@ -3780,7 +3780,7 @@ megasas_complete_cmd_dpc_fusion(unsigned long instance_addr)
>  /**
>   * megasas_isr_fusion - isr entry point
>   */
> -irqreturn_t megasas_isr_fusion(int irq, void *devp)
> +static irqreturn_t megasas_isr_fusion(int irq, void *devp)
>  {
>         struct megasas_irq_context *irq_context = devp;
>         struct megasas_instance *instance = irq_context->instance;
> @@ -3816,7 +3816,7 @@ irqreturn_t megasas_isr_fusion(int irq, void *devp)
>   * mfi_cmd:                    megasas_cmd pointer
>   *
>   */
> -void
> +static void
>  build_mpt_mfi_pass_thru(struct megasas_instance *instance,
>                         struct megasas_cmd *mfi_cmd)
>  {
> @@ -3874,7 +3874,7 @@ build_mpt_mfi_pass_thru(struct megasas_instance *instance,
>   * @cmd:                       mfi cmd to build
>   *
>   */
> -union MEGASAS_REQUEST_DESCRIPTOR_UNION *
> +static union MEGASAS_REQUEST_DESCRIPTOR_UNION *
>  build_mpt_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd)
>  {
>         union MEGASAS_REQUEST_DESCRIPTOR_UNION *req_desc = NULL;
> @@ -3900,7 +3900,7 @@ build_mpt_cmd(struct megasas_instance *instance, struct megasas_cmd *cmd)
>   * @cmd:                       mfi cmd pointer
>   *
>   */
> -void
> +static void
>  megasas_issue_dcmd_fusion(struct megasas_instance *instance,
>                           struct megasas_cmd *cmd)
>  {
> @@ -4096,8 +4096,9 @@ static inline void megasas_trigger_snap_dump(struct megasas_instance *instance)
>  }
>
>  /* This function waits for outstanding commands on fusion to complete */
> -int megasas_wait_for_outstanding_fusion(struct megasas_instance *instance,
> -                                       int reason, int *convert)
> +static int
> +megasas_wait_for_outstanding_fusion(struct megasas_instance *instance,
> +                                   int reason, int *convert)
>  {
>         int i, outstanding, retval = 0, hb_seconds_missed = 0;
>         u32 fw_state, abs_state;
> @@ -4221,7 +4222,7 @@ void  megasas_reset_reply_desc(struct megasas_instance *instance)
>   * megasas_refire_mgmt_cmd :   Re-fire management commands
>   * @instance:                          Controller's soft instance
>  */
> -void megasas_refire_mgmt_cmd(struct megasas_instance *instance)
> +static void megasas_refire_mgmt_cmd(struct megasas_instance *instance)
>  {
>         int j;
>         struct megasas_cmd_fusion *cmd_fusion;
> @@ -4747,7 +4748,8 @@ int megasas_reset_target_fusion(struct scsi_cmnd *scmd)
>  }
>
>  /*SRIOV get other instance in cluster if any*/
> -struct megasas_instance *megasas_get_peer_instance(struct megasas_instance *instance)
> +static struct
> +megasas_instance *megasas_get_peer_instance(struct megasas_instance *instance)
>  {
>         int i;
>
> @@ -5053,7 +5055,7 @@ int megasas_reset_fusion(struct Scsi_Host *shost, int reason)
>  }
>
>  /* Fusion Crash dump collection */
> -void  megasas_fusion_crash_dump(struct megasas_instance *instance)
> +static void  megasas_fusion_crash_dump(struct megasas_instance *instance)
>  {
>         u32 status_reg;
>         u8 partial_copy = 0;
> --
> 2.7.4
>
>
