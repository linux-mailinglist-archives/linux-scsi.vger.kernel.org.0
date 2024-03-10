Return-Path: <linux-scsi+bounces-3142-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CEC87786C
	for <lists+linux-scsi@lfdr.de>; Sun, 10 Mar 2024 21:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFB828142E
	for <lists+linux-scsi@lfdr.de>; Sun, 10 Mar 2024 20:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4D73A1BC;
	Sun, 10 Mar 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1j4TJ4o/"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50642364D4
	for <linux-scsi@vger.kernel.org>; Sun, 10 Mar 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710102248; cv=none; b=dGvLbnCahcYYJYhN9AqDDnSOsVw2FOmenAjtwMaD9GNm1mHWgxDJ+azcvVZRqeVVrqNLmoleyEyAF+aRRncVQTu3NzM6uaB2XB3a8HeAZA/7Z4VXGBJQxk9MJjj29zP5swYffo3LKmFtnVRVGWgLi4sEl/GwFxpH8OZ6r4b8ZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710102248; c=relaxed/simple;
	bh=O8DbNFsVu0PXCNulQIlC6UKYyZwOn82o6Bjs6LDf0vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqAbNMqhtoSBajneCzN0Pnda2VVfkuGozegw703hc26yfIZbSzhc32DyElQdZkjAChXzg1gFftYgKNRDW3Bs9w7O8Yq/u1b4B6V9+l6cNbjIjWRW38vhN41sNGxLjJTmpKIFJvGrlb44TkqnDlcfXqd2VgGFtZ30cLK+j97KnPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1j4TJ4o/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so2485592b3a.0
        for <linux-scsi@vger.kernel.org>; Sun, 10 Mar 2024 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710102247; x=1710707047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZMQf+Ye2ZVQSO6JB9xj+c1b6NVxfHLwgs9rIc81ssQ=;
        b=1j4TJ4o/n54NWgY5Wd/AKosuWxXgKWx2Xv1pgCbW1tRSTB0kaEi9ST8eEeuak5lcCp
         RH0juMcmVZ8nxzkCg2FCva48TrXN+Bc8el+CpZguulfohu1CU6L3dSSh3/HPn37Z1gY4
         uqDrIz568dTui1CxhqRTHzov8DtGi3UpmD4grxTCjaHdzfXixg5BBB9TFeW3YCW8qQXw
         swTGH4vOqP3GB+BbyDHKY2dKDkCFSdDdMIXTmP5Pb+S+ZfkicIAKvG8b1foz0k4lCHse
         SR/OHLdvbg0UNj8fH5C6P6VSVku+o3jPc/lWz25WeLEbR+PtiOWVheNNgp82powPmCCj
         iD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710102247; x=1710707047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZMQf+Ye2ZVQSO6JB9xj+c1b6NVxfHLwgs9rIc81ssQ=;
        b=QE1iXpjOXGOE4rW+CQlO69mwlYfnY3lI/S8vAmKrxD8Ujt6rwJ3yxj8rusC2ViGJi2
         VXOgS1jGuIAWFbZ3MiRGkBTOTOV6LAfoyXR1oQXIElex8xlC05qRIYUKfKubySo7vTLU
         WYjXhLy/3wkwy0Kz+8N41Y+wUlrv5Z5NgSbzm/gAzzV4eEEHa/WByj+yPy1MPLXVvNOB
         FGMsii+UN2nC9AY5NvTwYDuNpH4dXtIb5s0wP2jJba1C+k+ppDqpNBHJHt+XMIXpTaEl
         25/MQgwN5yt3f75AXNFNwZ2W0imqcekArhpv0+1fIntSy06fcr4U4M5CUw/1R1hHtCf8
         x4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9ktbvibkbj41CqbBB/QKkaAjmJd87X1wL8naGEj5G7MCxdLICslvsaAYt3U5puhVojMMAcjJXAne5pDZsaw/D843TqzpbuqnbpA==
X-Gm-Message-State: AOJu0Yywv5JgLpUf6skWjP9Mn9TPU1ed3QimA8AStlTcdg3vQOZC9BR9
	bVZOjBNYfbtqXuVn79W0vEc/piP8pXZf2eyLct9dt1ytB4gWdVL2TbF6+FLD3w==
X-Google-Smtp-Source: AGHT+IEitEoLI+argZZBmdbJfQEceMpqJqiBvBypTAD7KgFllGakbUEyuXaNfTw8IDE+Tjg+IhDUUQ==
X-Received: by 2002:a05:6a00:2e9d:b0:6e6:424c:b7eb with SMTP id fd29-20020a056a002e9d00b006e6424cb7ebmr6523641pfb.3.1710102246472;
        Sun, 10 Mar 2024 13:24:06 -0700 (PDT)
Received: from google.com ([2620:15c:2c5:13:d1de:e5bb:fcf:1314])
        by smtp.gmail.com with ESMTPSA id t35-20020a634623000000b005dccf48e2a5sm2897528pga.54.2024.03.10.13.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 13:24:06 -0700 (PDT)
Date: Sun, 10 Mar 2024 13:24:01 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: John Garry <john.g.garry@oracle.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com,
	chenxiang66@hisilicon.com, jinpu.wang@cloud.ionos.com,
	artur.paszkiewicz@intel.com, yanaijie@huawei.com,
	dlemoal@kernel.org, cassel@kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] scsi: mvsas: Use LIBSAS_SHT_BASE
Message-ID: <Ze4W4bEwdNET0188@google.com>
References: <20240308114339.1340549-1-john.g.garry@oracle.com>
 <20240308114339.1340549-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308114339.1340549-6-john.g.garry@oracle.com>

On Fri, Mar 08, 2024 at 11:43:38AM +0000, John Garry wrote:
> Use standard template for scsi_host_template structure to reduce
> duplication.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/scsi/mvsas/mv_init.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

Thanks,
Igor

> 
> diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> index 43ebb331e216..fb81d267c9cc 100644
> --- a/drivers/scsi/mvsas/mv_init.c
> +++ b/drivers/scsi/mvsas/mv_init.c
> @@ -30,28 +30,11 @@ static const struct attribute_group *mvst_host_groups[];
>  #define SOC_SAS_NUM 2
>  
>  static const struct scsi_host_template mvs_sht = {
> -	.module			= THIS_MODULE,
> -	.name			= DRV_NAME,
> -	.queuecommand		= sas_queuecommand,
> -	.dma_need_drain		= ata_scsi_dma_need_drain,
> -	.target_alloc		= sas_target_alloc,
> -	.slave_configure	= sas_slave_configure,
> +	LIBSAS_SHT_BASE
>  	.scan_finished		= mvs_scan_finished,
>  	.scan_start		= mvs_scan_start,
> -	.change_queue_depth	= sas_change_queue_depth,
> -	.bios_param		= sas_bios_param,
>  	.can_queue		= 1,
> -	.this_id		= -1,
>  	.sg_tablesize		= SG_ALL,
> -	.max_sectors		= SCSI_DEFAULT_MAX_SECTORS,
> -	.eh_device_reset_handler = sas_eh_device_reset_handler,
> -	.eh_target_reset_handler = sas_eh_target_reset_handler,
> -	.slave_alloc		= sas_slave_alloc,
> -	.target_destroy		= sas_target_destroy,
> -	.ioctl			= sas_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl		= sas_ioctl,
> -#endif
>  	.shost_groups		= mvst_host_groups,
>  	.track_queue_depth	= 1,
>  };
> -- 
> 2.31.1
> 

