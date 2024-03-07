Return-Path: <linux-scsi+bounces-3079-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65EF875887
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Mar 2024 21:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6242811E0
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Mar 2024 20:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B33E657AB;
	Thu,  7 Mar 2024 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wT8mYYPT"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3778634E9
	for <linux-scsi@vger.kernel.org>; Thu,  7 Mar 2024 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843753; cv=none; b=MaPhEsfzsWPENcVeOKXKpN8jxFZBVRtbhd6H37n2oOgrJfgqUtsulmjVCGVV8g4vBuzK0uozp43r7dTJGPn02KbDRnCcSNTvjqRZCiV2VIQ9aif+WaQDt1UMEDtQE4sPbmvBNlkGt5/RKVykM2zOWJOeFspowIkZuux7CN4qa+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843753; c=relaxed/simple;
	bh=/mM9XdqoNixs4g0r44HVvGUXKJUKNMwEWmTfaCJb2YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4mUf2xJEyIOQXlBCV4qggF5LsXls4f3ZVyecRy38LxtGpiEjQ5INeAf2bCZNv+ZnsHeQEJSnIjPKkyRFzU0hVqjQxD5tV9QfUSLmEMPNB2MNL6p5iDkOJU2+QI6aYBHnmFMRenih1G0U3GOhc+3yT0t/ECMe50iidfzYCEqlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wT8mYYPT; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29b73427790so877505a91.3
        for <linux-scsi@vger.kernel.org>; Thu, 07 Mar 2024 12:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709843750; x=1710448550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYdU1zXSNEoau5wZOigLf4pPixZPgoYe6P8fQG36tI8=;
        b=wT8mYYPTBZywVOqXuFfFcsnEJrXFmsyi7IyKhccWYnHOXWZGWZbr8ySj0hgtqSS8xW
         cV/kAY8Mo5AtYxp0c0e8cblu4vBqwu1Ny0vcuKPigddR0paEp1QWCDlHNNuzOSD9JrHw
         uhw0rTfoVRN/YDMcOnB0J7PNerJp2n+cHKxvPc2HzlO5kU0G8Y674IV9HnEE3QYlw2xs
         kr8By+Cg4sdZX/23FiUi0o5t5iwxnVJzIOgg3NOzEWP5IY8O0eHs3WNKmdZlDyInln70
         /1Tv3llbwWn/15m5JmSKrrXuYSRGXTqJQ11Mdot+DlCk85qTOqGZLaxTyshzyeAWr88Q
         R2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843750; x=1710448550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYdU1zXSNEoau5wZOigLf4pPixZPgoYe6P8fQG36tI8=;
        b=mAMIRkKT2zBdGG6d4PRl5Md3KfLTUVSLKc3Tn3qDuXz6cFUJFoBiA3FOlv9q+YtRVD
         mz0Yi1/XckHZOgBK7YfHzMDzgtgTODB4056mUwuc5F7CtdPznUbU5d6XSu3fHH1M465m
         cxtgrdqw8kL6QYGa3v06kga+YFZihjaeZW7lPNvZjocREbbNMbeJ/vmV+cADjO4I8hfe
         zQmqlRtE0Jsf6o4RJONthLU56uWM/oTy1BQ3OnWmjvNOvcdUJKPs+8TURAU8+5m037H8
         r7yiLzJNdR9DgyA35MZ+5pp4Vc2aXOxvSrLz5hYVA7gF38RngNXZl/SUy+fzhXQoRvyh
         vUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtI9EqeEQLW0b86tubPTDbWX+kbaawPUj9BMcZkQ6tslOVzchBn/uhcUdlVcsLZhndcmrZDboM2WM7R3MkSLSLvr+jvXFBBWMVCA==
X-Gm-Message-State: AOJu0YxllDJqQG6UyB50ZnCOtDkEgj+04Qd7Y8dd997XPykgbAlcs7pv
	ifF3dmMZi/NS8bJQqlNPm4BmZ/K+7VDL406GDbWVTM6yfv7LKhFqw3mDe4xvlg==
X-Google-Smtp-Source: AGHT+IGh8M/SViulVZWoIuLfNhNnpSxcXFCRgrZJ5Q4aq9NEY/tBUAm0vEE9MIj+8k0piW7JI1xFaQ==
X-Received: by 2002:a17:90a:9484:b0:29b:2c24:21ff with SMTP id s4-20020a17090a948400b0029b2c2421ffmr16134206pjo.39.1709843749488;
        Thu, 07 Mar 2024 12:35:49 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:69c0:c447:593d:278c])
        by smtp.gmail.com with ESMTPSA id kb12-20020a17090ae7cc00b0029ba8567fd9sm456375pjb.1.2024.03.07.12.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 12:35:49 -0800 (PST)
Date: Thu, 7 Mar 2024 12:35:44 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	Bart Van Assche <bvanassche@acm.org>,
	TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] scsi: mvsas: Add libsas SATA sysfs attributes
 group
Message-ID: <ZeolIAndjum4eGbf@google.com>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-5-ipylypiv@google.com>
 <ZehLl4AymauIvYl8@ryzen>
 <ZejccpVEsQTHjltB@google.com>
 <ZemOSKWkpatQzNlt@ryzen>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZemOSKWkpatQzNlt@ryzen>

On Thu, Mar 07, 2024 at 10:52:08AM +0100, Niklas Cassel wrote:
> On Wed, Mar 06, 2024 at 01:13:22PM -0800, Igor Pylypiv wrote:
> > On Wed, Mar 06, 2024 at 11:55:19AM +0100, Niklas Cassel wrote:
> > > On Tue, Mar 05, 2024 at 05:22:23PM -0800, Igor Pylypiv wrote:
> > > > The added sysfs attributes group enables the configuration of NCQ Priority
> > > > feature for HBAs that rely on libsas to manage SATA devices.
> > > > 
> > > > Reviewed-by: John Garry <john.g.garry@oracle.com>
> > > > Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> > > > Reviewed-by: Jason Yan <yanaijie@huawei.com>
> > > > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > > > ---
> > > >  drivers/scsi/mvsas/mv_init.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
> > > > index 43ebb331e216..f1090bb5f2c9 100644
> > > > --- a/drivers/scsi/mvsas/mv_init.c
> > > > +++ b/drivers/scsi/mvsas/mv_init.c
> > > > @@ -26,6 +26,7 @@ static const struct mvs_chip_info mvs_chips[] = {
> > > >  };
> > > >  
> > > >  static const struct attribute_group *mvst_host_groups[];
> > > > +static const struct attribute_group *mvst_sdev_groups[];
> > > 
> > > I think you can remove this line.
> > >
> > I kept the forward declaration to match the mvst_host_groups style.
> > 
> > Perhaps mvs_sht can be moved to the bottom of the file so that all forward
> > declarations can be removed? This can be done in a separate cleanup patch
> > series.
> > 
> > I'll keep this and aic94xx patches as-is, unless there are objections.
> 
> Usually, you first do the cleanup, then you do your changes.
> (That way, there are fewer lines changed, since each patch is smaller.)
> 

Ack. I think it makes sense to wait for the John's patch series
"Add LIBSAS_SHT_BASE for libsas" to get merged first:
https://lore.kernel.org/linux-scsi/20240305122452.340471-1-john.g.garry@oracle.com/T/#t

This way John woudn't need to re-do the patches on top of the moved sht.
Since the LIBSAS_SHT_BASE reduces the line count the following cleanup
patches will have fewer lines changed.

> But no objection from me.
> 
> 
> Kind regards,
> Niklas
> 
> 
> > 
> > > 
> > > >  
> > > >  #define SOC_SAS_NUM 2
> > > >  
> > > > @@ -53,6 +54,7 @@ static const struct scsi_host_template mvs_sht = {
> > > >  	.compat_ioctl		= sas_ioctl,
> > > >  #endif
> > > >  	.shost_groups		= mvst_host_groups,
> > > > +	.sdev_groups		= mvst_sdev_groups,
> > > >  	.track_queue_depth	= 1,
> > > >  };
> > > >  
> > > > @@ -779,6 +781,11 @@ static struct attribute *mvst_host_attrs[] = {
> > > >  
> > > >  ATTRIBUTE_GROUPS(mvst_host);
> > > >  
> > > > +static const struct attribute_group *mvst_sdev_groups[] = {
> > > > +	&sas_ata_sdev_attr_group,
> > > > +	NULL
> > > > +};
> > > 
> > > ..and move these lines up to be after:
> > > static const struct attribute_group *mvst_host_groups[];
> > > 
> > > 
> > > > +
> > > >  module_init(mvs_init);
> > > >  module_exit(mvs_exit);
> > > >  
> > > > -- 
> > > > 2.44.0.278.ge034bb2e1d-goog
> > > > 

