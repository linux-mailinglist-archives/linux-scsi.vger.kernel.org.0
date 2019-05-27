Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1028C2AF9B
	for <lists+linux-scsi@lfdr.de>; Mon, 27 May 2019 09:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfE0Hz4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 May 2019 03:55:56 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43061 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfE0Hzz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 27 May 2019 03:55:55 -0400
Received: by mail-vs1-f67.google.com with SMTP id d128so9981372vsc.10
        for <linux-scsi@vger.kernel.org>; Mon, 27 May 2019 00:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFa1SQkNwH4Y44uHm2Cyh5hjFOKo0uy61G9m+qlLMIk=;
        b=Y+9aj5mYUpnD6IyZV01X8CnOdcyUs8ABjaGG/lZyK0wI2hDTDiJg523p/tUmFQQSZO
         cIsRy/73igo7SUHBs6gOZW+LjTAKz1jIWjlKVls2RgFokqUxjZ4ht/PT6FK5GN+MKvWx
         UvT5WIfEX/3nlOXjllC1vO4zVvYg+s0zJaaGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFa1SQkNwH4Y44uHm2Cyh5hjFOKo0uy61G9m+qlLMIk=;
        b=qrYGBEyA/FGI7kIyjU9NwGkInZW6og4Am5q0G2j1shOnELCLxDtgnldhCDbONfG61e
         ENlGZRJv7ON52mO/MrBukJEnfJ8CjWJ6mLiT7oCQiTlHOs2HV2BqQbPnHc+gkEmA3sUS
         p1YUNpXzUBVO3DsLYGHAWx0tukQFunQN+I3L8a+qa9LTNvNpgTUBxsp5jQ1zp1TDjpH3
         y9DL1Oxh+DLAyWQwk7QXuuJ2WziPlw4Oj3VGpSxbQ/zM5cTWVqAp5EaX6uCAVEeIMKiY
         fFg1/OLo/WXkKASvIuwB1puj/Nx/6RiDEo661Rc8q+/VvhxAiNTah61BcESPUefma7LO
         1cgQ==
X-Gm-Message-State: APjAAAWbLa/twTsa8+I5b9E5lMkCzJsURKacA6UxZWXJzzZmugeY3afT
        GOUmX1CbuSGiTCrx/h/JmvNzIqeXjJ4A/B4j2wX+tg==
X-Google-Smtp-Source: APXvYqxdegIe1zRxV+S4Rv+q6Hm8vWH208TC1BXHn98vHSG26W/BjEq4W1ozSv5prkqG0u5NI/2O4LmFS+YdabdBpBI=
X-Received: by 2002:a67:e211:: with SMTP id g17mr43151380vsa.22.1558943754429;
 Mon, 27 May 2019 00:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190525123821.16528-1-yuehaibing@huawei.com>
In-Reply-To: <20190525123821.16528-1-yuehaibing@huawei.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Mon, 27 May 2019 13:25:42 +0530
Message-ID: <CAL2rwxrnaOz-wNgK125XfO2CYhhsY43Vv1Az_QCp_wYhKmE-zA@mail.gmail.com>
Subject: Re: [PATCH -next] scsi: megaraid_sas: remove set but not used
 variable 'cur_state'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>, jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        "PDL,MEGARAIDLINUX" <megaraidlinux.pdl@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, May 25, 2019 at 6:08 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/scsi/megaraid/megaraid_sas_base.c: In function megasas_transition_to_ready:
> drivers/scsi/megaraid/megaraid_sas_base.c:3900:6: warning: variable cur_state set but not used [-Wunused-but-set-variable]
>
> It's not used any more since commit 7218df69e360 ("[SCSI]
> megaraid_sas: use the firmware boot timeout when waiting for commands")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 25281a2eb424..39d173ed5b69 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -3897,7 +3897,6 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
>         int i;
>         u8 max_wait;
>         u32 fw_state;
> -       u32 cur_state;
>         u32 abs_state, curr_abs_state;
>
>         abs_state = instance->instancet->read_fw_status_reg(instance);
> @@ -3918,7 +3917,6 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
>                                    abs_state & MFI_STATE_FAULT_SUBCODE, __func__);
>                         if (ocr) {
>                                 max_wait = MEGASAS_RESET_WAIT_TIME;
> -                               cur_state = MFI_STATE_FAULT;
>                                 break;
>                         } else {
>                                 dev_printk(KERN_DEBUG, &instance->pdev->dev, "System Register set:\n");
> @@ -3944,7 +3942,6 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
>                                         &instance->reg_set->inbound_doorbell);
>
>                         max_wait = MEGASAS_RESET_WAIT_TIME;
> -                       cur_state = MFI_STATE_WAIT_HANDSHAKE;
>                         break;
>
>                 case MFI_STATE_BOOT_MESSAGE_PENDING:
> @@ -3960,7 +3957,6 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
>                                         &instance->reg_set->inbound_doorbell);
>
>                         max_wait = MEGASAS_RESET_WAIT_TIME;
> -                       cur_state = MFI_STATE_BOOT_MESSAGE_PENDING;
>                         break;
>
>                 case MFI_STATE_OPERATIONAL:
> @@ -3993,7 +3989,6 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
>                                         &instance->reg_set->inbound_doorbell);
>
>                         max_wait = MEGASAS_RESET_WAIT_TIME;
> -                       cur_state = MFI_STATE_OPERATIONAL;
>                         break;
>
>                 case MFI_STATE_UNDEFINED:
> @@ -4001,32 +3996,26 @@ megasas_transition_to_ready(struct megasas_instance *instance, int ocr)
>                          * This state should not last for more than 2 seconds
>                          */
>                         max_wait = MEGASAS_RESET_WAIT_TIME;
> -                       cur_state = MFI_STATE_UNDEFINED;
>                         break;
>
>                 case MFI_STATE_BB_INIT:
>                         max_wait = MEGASAS_RESET_WAIT_TIME;
> -                       cur_state = MFI_STATE_BB_INIT;
>                         break;
>
>                 case MFI_STATE_FW_INIT:
>                         max_wait = MEGASAS_RESET_WAIT_TIME;
> -                       cur_state = MFI_STATE_FW_INIT;
>                         break;
>
>                 case MFI_STATE_FW_INIT_2:
>                         max_wait = MEGASAS_RESET_WAIT_TIME;
> -                       cur_state = MFI_STATE_FW_INIT_2;
>                         break;
>
>                 case MFI_STATE_DEVICE_SCAN:
>                         max_wait = MEGASAS_RESET_WAIT_TIME;
> -                       cur_state = MFI_STATE_DEVICE_SCAN;
>                         break;
>
>                 case MFI_STATE_FLUSH_CACHE:
>                         max_wait = MEGASAS_RESET_WAIT_TIME;
> -                       cur_state = MFI_STATE_FLUSH_CACHE;
>                         break;
>
>                 default:
> --
> 2.17.1
>
>
