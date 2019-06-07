Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADF7A384C9
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 09:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfFGHPO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 03:15:14 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39663 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfFGHPO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 03:15:14 -0400
Received: by mail-ua1-f65.google.com with SMTP id j8so286723uan.6
        for <linux-scsi@vger.kernel.org>; Fri, 07 Jun 2019 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5ctLUVxwpypsDBx5BI/a6Ozji4Kgc6Uzny5C6uw6cY=;
        b=D62ouOeR9K0jc1AwhE77+4cdg3dCE3RBDuSESG4UatFFrN05MSxOpobnNoKwPieC2m
         SVWN78825KEwEA22fVc+AxdQrwx3GkztT8PPCPLkxthwro9K+cpV8zkOtpqFM1ZZ7NcJ
         Bh4SfIGNYeuYecWoAqQ/DlJrX+NzUlgnrI33I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5ctLUVxwpypsDBx5BI/a6Ozji4Kgc6Uzny5C6uw6cY=;
        b=fI+xyUDrSZKRKaeVCg+N6ue767iFnJ/2IHglFncCnEoG8LItk/nhy0QTAYRwJsp+3p
         s81kdn/2UtnQ2Q5Ymkr1qDWmWsLDSASLom7YzxcCPUpqXKMvzOaR9UwPRdM4mx/+VxVF
         0elntMYuDmLRwtIpCPO7RU2dMxQ07nv3ccbFx9jvxjd/He8Lq0N6wCrLCV74YWbaivEr
         bBttaldhftyzbbHFEQs4Adc5Y+J4kVKhO/b0KBu4gURoW4GfEK50QEKmPAUTFe/vf/Vl
         jJ7aNHZm6td+taDnKZ4yoKBLTLeMwzO3G4beRBFH+JOxtQWQvEawX99EOjOmMPAMKO4e
         EL5w==
X-Gm-Message-State: APjAAAWpL9NDfm+xIiiFeNZCN3aCPpiSrFM0o62A8Ip2zUQtsSX61CDI
        XsImnLy6YnR4PeJQP+fzjgHf5iR/rPUsx5FKos5cXw==
X-Google-Smtp-Source: APXvYqxyDnDsPRy088RYb0eN2n6jBhCX4JO3lHN2+zxkBwevC0kUCo71JkYCbjawXt30zBR94d9ynLL/+VaxhV1V56I=
X-Received: by 2002:ab0:5499:: with SMTP id p25mr19421555uaa.2.1559891713390;
 Fri, 07 Jun 2019 00:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190529160041.7242-1-thenzl@redhat.com> <20190529160041.7242-4-thenzl@redhat.com>
In-Reply-To: <20190529160041.7242-4-thenzl@redhat.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Fri, 7 Jun 2019 12:45:01 +0530
Message-ID: <CAL2rwxr4tK0kK1OKr4q=+V8YrUrDkTivKHQPT8fGmpm00zDc7g@mail.gmail.com>
Subject: Re: [PATCH 3/3] megaraid_sas: use DEVICE_ATTR_{RO, RW}
To:     Tomas Henzl <thenzl@redhat.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, May 29, 2019 at 9:30 PM Tomas Henzl <thenzl@redhat.com> wrote:
>
> Use existing macros.
> No functional change.
>
> Signed-off-by: Tomas Henzl <thenzl@redhat.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>

> ---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 44 ++++++++++-------------
>  1 file changed, 18 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 0522821a5..aa6a5d86d 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -3121,7 +3121,7 @@ megasas_service_aen(struct megasas_instance *instance, struct megasas_cmd *cmd)
>  }
>
>  static ssize_t
> -megasas_fw_crash_buffer_store(struct device *cdev,
> +fw_crash_buffer_store(struct device *cdev,
>         struct device_attribute *attr, const char *buf, size_t count)
>  {
>         struct Scsi_Host *shost = class_to_shost(cdev);
> @@ -3140,7 +3140,7 @@ megasas_fw_crash_buffer_store(struct device *cdev,
>  }
>
>  static ssize_t
> -megasas_fw_crash_buffer_show(struct device *cdev,
> +fw_crash_buffer_show(struct device *cdev,
>         struct device_attribute *attr, char *buf)
>  {
>         struct Scsi_Host *shost = class_to_shost(cdev);
> @@ -3185,7 +3185,7 @@ megasas_fw_crash_buffer_show(struct device *cdev,
>  }
>
>  static ssize_t
> -megasas_fw_crash_buffer_size_show(struct device *cdev,
> +fw_crash_buffer_size_show(struct device *cdev,
>         struct device_attribute *attr, char *buf)
>  {
>         struct Scsi_Host *shost = class_to_shost(cdev);
> @@ -3197,7 +3197,7 @@ megasas_fw_crash_buffer_size_show(struct device *cdev,
>  }
>
>  static ssize_t
> -megasas_fw_crash_state_store(struct device *cdev,
> +fw_crash_state_store(struct device *cdev,
>         struct device_attribute *attr, const char *buf, size_t count)
>  {
>         struct Scsi_Host *shost = class_to_shost(cdev);
> @@ -3232,7 +3232,7 @@ megasas_fw_crash_state_store(struct device *cdev,
>  }
>
>  static ssize_t
> -megasas_fw_crash_state_show(struct device *cdev,
> +fw_crash_state_show(struct device *cdev,
>         struct device_attribute *attr, char *buf)
>  {
>         struct Scsi_Host *shost = class_to_shost(cdev);
> @@ -3243,14 +3243,14 @@ megasas_fw_crash_state_show(struct device *cdev,
>  }
>
>  static ssize_t
> -megasas_page_size_show(struct device *cdev,
> +page_size_show(struct device *cdev,
>         struct device_attribute *attr, char *buf)
>  {
>         return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)PAGE_SIZE - 1);
>  }
>
>  static ssize_t
> -megasas_ldio_outstanding_show(struct device *cdev, struct device_attribute *attr,
> +ldio_outstanding_show(struct device *cdev, struct device_attribute *attr,
>         char *buf)
>  {
>         struct Scsi_Host *shost = class_to_shost(cdev);
> @@ -3260,7 +3260,7 @@ megasas_ldio_outstanding_show(struct device *cdev, struct device_attribute *attr
>  }
>
>  static ssize_t
> -megasas_fw_cmds_outstanding_show(struct device *cdev,
> +fw_cmds_outstanding_show(struct device *cdev,
>                                  struct device_attribute *attr, char *buf)
>  {
>         struct Scsi_Host *shost = class_to_shost(cdev);
> @@ -3270,7 +3270,7 @@ megasas_fw_cmds_outstanding_show(struct device *cdev,
>  }
>
>  static ssize_t
> -megasas_dump_system_regs_show(struct device *cdev,
> +dump_system_regs_show(struct device *cdev,
>                                struct device_attribute *attr, char *buf)
>  {
>         struct Scsi_Host *shost = class_to_shost(cdev);
> @@ -3281,7 +3281,7 @@ megasas_dump_system_regs_show(struct device *cdev,
>  }
>
>  static ssize_t
> -megasas_raid_map_id_show(struct device *cdev, struct device_attribute *attr,
> +raid_map_id_show(struct device *cdev, struct device_attribute *attr,
>                           char *buf)
>  {
>         struct Scsi_Host *shost = class_to_shost(cdev);
> @@ -3292,22 +3292,14 @@ megasas_raid_map_id_show(struct device *cdev, struct device_attribute *attr,
>                         (unsigned long)instance->map_id);
>  }
>
> -static DEVICE_ATTR(fw_crash_buffer, S_IRUGO | S_IWUSR,
> -       megasas_fw_crash_buffer_show, megasas_fw_crash_buffer_store);
> -static DEVICE_ATTR(fw_crash_buffer_size, S_IRUGO,
> -       megasas_fw_crash_buffer_size_show, NULL);
> -static DEVICE_ATTR(fw_crash_state, S_IRUGO | S_IWUSR,
> -       megasas_fw_crash_state_show, megasas_fw_crash_state_store);
> -static DEVICE_ATTR(page_size, S_IRUGO,
> -       megasas_page_size_show, NULL);
> -static DEVICE_ATTR(ldio_outstanding, S_IRUGO,
> -       megasas_ldio_outstanding_show, NULL);
> -static DEVICE_ATTR(fw_cmds_outstanding, S_IRUGO,
> -       megasas_fw_cmds_outstanding_show, NULL);
> -static DEVICE_ATTR(dump_system_regs, S_IRUGO,
> -       megasas_dump_system_regs_show, NULL);
> -static DEVICE_ATTR(raid_map_id, S_IRUGO,
> -       megasas_raid_map_id_show, NULL);
> +static DEVICE_ATTR_RW(fw_crash_buffer);
> +static DEVICE_ATTR_RO(fw_crash_buffer_size);
> +static DEVICE_ATTR_RW(fw_crash_state);
> +static DEVICE_ATTR_RO(page_size);
> +static DEVICE_ATTR_RO(ldio_outstanding);
> +static DEVICE_ATTR_RO(fw_cmds_outstanding);
> +static DEVICE_ATTR_RO(dump_system_regs);
> +static DEVICE_ATTR_RO(raid_map_id);
>
>  struct device_attribute *megaraid_host_attrs[] = {
>         &dev_attr_fw_crash_buffer_size,
> --
> 2.20.1
>
