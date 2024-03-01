Return-Path: <linux-scsi+bounces-2822-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6018586EC10
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Mar 2024 23:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBC311F24586
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Mar 2024 22:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A5B5EE6A;
	Fri,  1 Mar 2024 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBh2Fiqx"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A0A58ADD
	for <linux-scsi@vger.kernel.org>; Fri,  1 Mar 2024 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709333903; cv=none; b=sED66AjfRFSol3Nuiye1fv8AzJGPnaPTPKNX1D3h+Hko6NFxorOR58bwX4YxIbOh4bfRJBvi23MaU66jCND3Vk2g1RLUY1T81z/NPh1JtNwldVpiWQ149aaEG2saWgAKSumUoVP24cpgGoV+pvZxSQ0VcRkM/F7cG217iFo6Q34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709333903; c=relaxed/simple;
	bh=51KB5+vvp50PJGbtC9xrC66p7mH4YglnZrE21oCXX2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTI7r0LnSJwuB8atcI2JrWHebVis0Ui52izxjB7XcJ+IKqn7GypUXMWyevrx4FxGXdwpYD+MaJD57XSFSAUkYW44dcO2u6D6VSmV4KqotGi0y1DXC1USuuwoLMaH7ccyUL1jg0cma5iZ5Qhe8L3Z7n0nsQMYmrhLhjBUPBCIYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBh2Fiqx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dbd32cff0bso25451265ad.0
        for <linux-scsi@vger.kernel.org>; Fri, 01 Mar 2024 14:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709333901; x=1709938701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6g1OLHSuggYt4HmBeuvmTIADaRmlIR+NeOpy8jozz8=;
        b=ZBh2FiqxuGh6J3n/qlqLeg65p3yniyLzTx12J3bQX1wTgp4xh5f61RcaOjoDeyUILr
         mrKdE0HtKJjGtg8zxdSnMUotNeVm9jdoZajLK83n0METqy0W2alHnYxbvx1kk1gLMmmG
         6dCdEMdBTRvUIC/wZV1R7imfBZuGAdtpIdiCaHwdXXt42dwvfyVuCf0dCRDe1Kv60AK0
         XAmM3QgC//Cu3HEpqXPK6jP8/VxGJY3PFwMG/rEpZ7waTJ1IiNTeDA4dHGDl3AtSVqCe
         vKkXdjJL1ck5zkSuSrxKYWBYWYtN+HXTQzYXn0z/5YYikDXmyMNXL1f2DndRxuWNLWCN
         SxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709333901; x=1709938701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6g1OLHSuggYt4HmBeuvmTIADaRmlIR+NeOpy8jozz8=;
        b=Qe0qwbax9JepS5LoYFGSBjctdA5VmhE9tRdNA0vkPWq20qMGE3tG2jjZ9XYdHTPC8u
         L7wq5da03JjS6jAPN8pOVtglqGPkpc1tcEsIkxl3KprwJ93BK+WK/mXFyepBKWJZH3af
         M4JCC1l3RHjnm4Y7x5NK+ZGhkQbf8YRDsuVlHP9yB/StUnzG1ZPNSj9jm/aUANFM8blf
         eokpTem09PiJexJ7PpvFAqw6Owx5IHls6d3rakXFU6FmUAfrTgiUGsuux3oAa6nnErUL
         bU4l5vmz/GXrG0MGa3QwnNgEG/SO0WzSQvq5Fg7nN/zUuB6eNSSitcZnMZxDlyN+wWmW
         GQvw==
X-Forwarded-Encrypted: i=1; AJvYcCV9iTLhJ0+BT11Nz5Jih1DWz9GPsJ8NpxeE4X+RTH1ZBFWJB0ri+tcgBGm71UiMExFNtLSpNVMl4OtPQwF5/ZliGdeqbIf72LBC8A==
X-Gm-Message-State: AOJu0YzbYOXqtB6RluziL3kKypz0+qtT7YIyHeRPSNC+leuSIS+05rdn
	YuVrfKqSd/UBw5DW3CvwjvdjU5ZD/Zm/8w+W+hlYf1OU9SVff1f2MiQvvY5mSg==
X-Google-Smtp-Source: AGHT+IETYSjSOG6KqSy6QCk4leF3enmG7L6jYEl8vFqW/GClW+wK0VLRCN407+12espzX+46qWkfzg==
X-Received: by 2002:a17:902:ccc2:b0:1db:c6a0:288b with SMTP id z2-20020a170902ccc200b001dbc6a0288bmr3464674ple.7.1709333901046;
        Fri, 01 Mar 2024 14:58:21 -0800 (PST)
Received: from google.com ([2620:15c:2c5:13:2afe:1a8e:f846:999f])
        by smtp.gmail.com with ESMTPSA id kv13-20020a17090328cd00b001d911dd145esm3980166plb.219.2024.03.01.14.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 14:58:20 -0800 (PST)
Date: Fri, 1 Mar 2024 14:58:15 -0800
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jack Wang <jinpu.wang@cloud.ionos.com>,
	Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	TJ Adams <tadamsjr@google.com>
Subject: Re: [PATCH 1/3] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
Message-ID: <ZeJdhyYsUVUwpCL8@google.com>
References: <20240301013759.516817-1-ipylypiv@google.com>
 <20240301013759.516817-2-ipylypiv@google.com>
 <cee98fdf-d285-44da-8bcb-9d9150a19e5e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cee98fdf-d285-44da-8bcb-9d9150a19e5e@kernel.org>

On Fri, Mar 01, 2024 at 04:16:46AM -0800, Damien Le Moal wrote:

Thank you for the review Damien!

> On 2024/02/29 17:37, Igor Pylypiv wrote:
> > Export libata NCQ Priority configuration helpers to be reused
> > for libsas managed SATA devices.
> > 
> > Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> > Reviewed-by: TJ Adams <tadamsjr@google.com>
> 
> Please drop this tag as the email signaling the review was not sent to the
> list/in-reply to this email. The name of the reviewer should also be fully
> spelled out. Same comment for the other 2 patches as they also have this review tag.
> 
> > ---
> >  drivers/ata/libata-sata.c | 130 +++++++++++++++++++++++++-------------
> >  include/linux/libata.h    |   4 ++
> >  2 files changed, 90 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> > index 0fb1934875f2..9c6c69d7feab 100644
> > --- a/drivers/ata/libata-sata.c
> > +++ b/drivers/ata/libata-sata.c
> > @@ -848,80 +848,104 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
> >  	    ata_scsi_lpm_show, ata_scsi_lpm_store);
> >  EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
> >  
> > +/**
> > + *	ata_ncq_prio_supported - Check if device supports NCQ Priority
> > + *	@ap: ATA port of the target device
> > + *	@sdev: SCSI device
> > + *
> > + *	Helper to check if device supports NCQ Priority feature,
> > + *	usable with both libsas and libata.
> > + */
> > +int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev)
> > +{
> > +	struct ata_device *dev;
> > +	unsigned long flags;
> > +	int rc;
> > +
> > +	spin_lock_irqsave(ap->lock, flags);
> > +	dev = ata_scsi_find_dev(ap, sdev);
> > +	rc = dev ? !!(dev->flags & ATA_DFLAG_NCQ_PRIO) : -ENODEV;
> 
> Please expand this to make it more readable:
> 
> 	if (!dev)
> 		rc = -ENODEV;
> 	else
> 		rc = !!(dev->flags & ATA_DFLAG_NCQ_PRIO);
> 
> > +	spin_unlock_irqrestore(ap->lock, flags);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(ata_ncq_prio_supported);
> > +
> >  static ssize_t ata_ncq_prio_supported_show(struct device *device,
> >  					   struct device_attribute *attr,
> >  					   char *buf)
> >  {
> >  	struct scsi_device *sdev = to_scsi_device(device);
> >  	struct ata_port *ap = ata_shost_to_port(sdev->host);
> > -	struct ata_device *dev;
> > -	bool ncq_prio_supported;
> > -	int rc = 0;
> > -
> > -	spin_lock_irq(ap->lock);
> > -	dev = ata_scsi_find_dev(ap, sdev);
> > -	if (!dev)
> > -		rc = -ENODEV;
> > -	else
> > -		ncq_prio_supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
> > -	spin_unlock_irq(ap->lock);
> > +	int rc = ata_ncq_prio_supported(ap, sdev);
> >  
> > -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
> > +	return (rc < 0) ? rc : sysfs_emit(buf, "%u\n", rc);
> 
> Same here, please expand:
> 
> 	if (rc < 0)
> 		return rc;
> 	return sysfs_emit(buf, "%d\n", rc);
> 
> And please not the change %u -> %d
> 
> >  }
> > -
> 
> whiteline change. Please keep the white line.
> 
> >  DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
> >  EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
> >  
> > +/**
> > + *	ata_ncq_prio_enabled - Check if NCQ Priority is enabled
> > + *	@ap: ATA port of the target device
> > + *	@sdev: SCSI device
> > + *
> > + *	Helper to check if NCQ Priority feature is enabled,
> > + *	usable with both libsas and libata.
> > + */
> > +int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev)
> > +{
> > +	struct ata_device *dev;
> > +	unsigned long flags;
> > +	int rc;
> > +
> > +	spin_lock_irqsave(ap->lock, flags);
> > +	dev = ata_scsi_find_dev(ap, sdev);
> > +	rc = dev ? !!(dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) : -ENODEV;
> 
> same comment as above. Please expand.
> 
> > +	spin_unlock_irqrestore(ap->lock, flags);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(ata_ncq_prio_enabled);
> > +
> >  static ssize_t ata_ncq_prio_enable_show(struct device *device,
> >  					struct device_attribute *attr,
> >  					char *buf)
> >  {
> >  	struct scsi_device *sdev = to_scsi_device(device);
> >  	struct ata_port *ap = ata_shost_to_port(sdev->host);
> > -	struct ata_device *dev;
> > -	bool ncq_prio_enable;
> > -	int rc = 0;
> > -
> > -	spin_lock_irq(ap->lock);
> > -	dev = ata_scsi_find_dev(ap, sdev);
> > -	if (!dev)
> > -		rc = -ENODEV;
> > -	else
> > -		ncq_prio_enable = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
> > -	spin_unlock_irq(ap->lock);
> > +	int rc = ata_ncq_prio_enabled(ap, sdev);
> >  
> > -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
> > +	return (rc < 0) ? rc : sysfs_emit(buf, "%u\n", rc);
> 
> same comment as above.
> 
> >  }
> >  
> > -static ssize_t ata_ncq_prio_enable_store(struct device *device,
> > -					 struct device_attribute *attr,
> > -					 const char *buf, size_t len)
> > +/**
> > + *	ata_ncq_prio_enable - Enable/disable NCQ Priority
> > + *	@ap: ATA port of the target device
> > + *	@sdev: SCSI device
> > + *	@enable: true - enable NCQ Priority, false - disable NCQ Priority
> > + *
> > + *	Helper to enable/disable NCQ Priority feature, usable with both
> > + *	libsas and libata.
> > + */
> > +int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
> > +			bool enable)
> >  {
> > -	struct scsi_device *sdev = to_scsi_device(device);
> > -	struct ata_port *ap;
> >  	struct ata_device *dev;
> > -	long int input;
> > +	unsigned long flags;
> >  	int rc = 0;
> >  
> > -	rc = kstrtol(buf, 10, &input);
> > -	if (rc)
> > -		return rc;
> > -	if ((input < 0) || (input > 1))
> > -		return -EINVAL;
> > +	spin_lock_irqsave(ap->lock, flags);
> 
> Any reason to not use spin_lock_irq() ?

In the future someone might call these helper functions when interrupts
are disabled. spin_unlock_irq() might re-enable interrupts prematurely.
spin_unlock_irqrestore() will restore the same interrupts state that was
before the call to spin_lock_irqsave().

> 
> >  
> > -	ap = ata_shost_to_port(sdev->host);
> >  	dev = ata_scsi_find_dev(ap, sdev);
> > -	if (unlikely(!dev))
> > -		return  -ENODEV;
> > -
> > -	spin_lock_irq(ap->lock);
> > +	if (unlikely(!dev)) {
> > +		rc = -ENODEV;
> > +		goto unlock;
> > +	}
> >  
> >  	if (!(dev->flags & ATA_DFLAG_NCQ_PRIO)) {
> >  		rc = -EINVAL;
> >  		goto unlock;
> >  	}
> >  
> > -	if (input) {
> > +	if (enable) {
> >  		if (dev->flags & ATA_DFLAG_CDL_ENABLED) {
> >  			ata_dev_err(dev,
> >  				"CDL must be disabled to enable NCQ priority\n");
> > @@ -934,9 +958,27 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
> >  	}
> >  
> >  unlock:
> > -	spin_unlock_irq(ap->lock);
> > +	spin_unlock_irqrestore(ap->lock, flags);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_GPL(ata_ncq_prio_enable);
> > +
> > +static ssize_t ata_ncq_prio_enable_store(struct device *device,
> > +					 struct device_attribute *attr,
> > +					 const char *buf, size_t len)
> > +{
> > +	struct scsi_device *sdev = to_scsi_device(device);
> > +	struct ata_port *ap = ata_shost_to_port(sdev->host);
> > +	long input;
> > +	int rc = 0;
> > +
> > +	rc = kstrtol(buf, 10, &input);
> 
> Please use kstrtobool().
> 
> > +	if (rc)
> > +		return rc;
> > +	if ((input < 0) || (input > 1))
> > +		return -EINVAL;
> >  
> > -	return rc ? rc : len;
> > +	return ata_ncq_prio_enable(ap, sdev, input) ? : len;
> >  }
> >  
> >  DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
> > diff --git a/include/linux/libata.h b/include/linux/libata.h
> > index 26d68115afb8..f3ff2bf3ec6b 100644
> > --- a/include/linux/libata.h
> > +++ b/include/linux/libata.h
> > @@ -1157,6 +1157,10 @@ extern int ata_scsi_change_queue_depth(struct scsi_device *sdev,
> >  				       int queue_depth);
> >  extern int ata_change_queue_depth(struct ata_port *ap, struct scsi_device *sdev,
> >  				  int queue_depth);
> > +extern int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev);
> > +extern int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev);
> > +extern int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
> > +			       bool enable);
> >  extern struct ata_device *ata_dev_pair(struct ata_device *adev);
> >  extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
> >  extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 

