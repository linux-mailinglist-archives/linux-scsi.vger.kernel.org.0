Return-Path: <linux-scsi+bounces-3013-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86452873511
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Mar 2024 11:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80EC1C2523A
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Mar 2024 10:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B92745E0;
	Wed,  6 Mar 2024 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XECsnAPh"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C9374E3F;
	Wed,  6 Mar 2024 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722565; cv=none; b=pATur0I+jbLgS9FGwPPSL9cefuYtGcriwsqiEfAjxP5AUH/6OiOyGhASuqUSClW/dM22+XGdrgD0pfhCMvZhokY7wdWBYGdd3dNfWEi75pEqkBFfxd6qt4Ntj/3KCpeJR4V74k2vmykkERgnXwGJq/anSwA82gWOUQbIZWKHfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722565; c=relaxed/simple;
	bh=qPLE9pnjp0gZWz1pq4YlCO7VFKBFUXWYe4LM/H0qIIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpIf+k12OxW0047Wt9NBIEYq5FN4BI3+X2QgWoLFOcJUmNDSdsJ0Q8ac6T83VSahDPiPnStqiNHV5n2wDUewqQOiDijFSfpgT71HaVUWKIBSGL0bVwI2QCvcEsRfTKt9zIBOgg8mW2DZurtinFEriL99XlwzH1Of1NH2kadDudk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XECsnAPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA8BC433F1;
	Wed,  6 Mar 2024 10:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722565;
	bh=qPLE9pnjp0gZWz1pq4YlCO7VFKBFUXWYe4LM/H0qIIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XECsnAPhw7UnxyfZSnhfKAn9S2k1A5MRjYeJxEWvL25mMHz1WOJ9NYaduLtn6n8Du
	 ODpXO/pXdfUvpcNQ9R3g9JGqXcLJ4OVZYNo+E0doi1qaCg9//Bx5ZD8gRmRK9KtogL
	 O/JRiNNG1X2IKP71RNpHnH5MRvIWalp1YYfwhT/BTzOdx3S00n9vuzIX5qiu2eOhKG
	 Ap0QIKCFmu2BO4jUGcu7FEVtRJ0cv8HTNvuWE42UK/54htlPvbXEpHJc4mQFqCs6tO
	 Kd22sRA/AcZ9uLuiOuasr3BJVrCat4j9ILZ2InS+ypVTcvgRA0AkEMSJ/MNkD3u9Vu
	 uH5EGuc74ZYzw==
Date: Wed, 6 Mar 2024 11:55:59 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Igor Pylypiv <ipylypiv@google.com>
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
Subject: Re: [PATCH v7 7/7] scsi: isci: Add libsas SATA sysfs attributes group
Message-ID: <ZehLv6ADtU4cU3rr@ryzen>
References: <20240306012226.3398927-1-ipylypiv@google.com>
 <20240306012226.3398927-8-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306012226.3398927-8-ipylypiv@google.com>

On Tue, Mar 05, 2024 at 05:22:26PM -0800, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>  drivers/scsi/isci/init.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
> index 6277162a028b..8658dcd61b87 100644
> --- a/drivers/scsi/isci/init.c
> +++ b/drivers/scsi/isci/init.c
> @@ -149,6 +149,11 @@ static struct attribute *isci_host_attrs[] = {
>  
>  ATTRIBUTE_GROUPS(isci_host);
>  
> +static const struct attribute_group *isci_sdev_groups[] = {
> +	&sas_ata_sdev_attr_group,
> +	NULL
> +};
> +
>  static const struct scsi_host_template isci_sht = {
>  
>  	.module				= THIS_MODULE,
> @@ -176,6 +181,7 @@ static const struct scsi_host_template isci_sht = {
>  	.compat_ioctl			= sas_ioctl,
>  #endif
>  	.shost_groups			= isci_host_groups,
> +	.sdev_groups			= isci_sdev_groups,
>  	.track_queue_depth		= 1,
>  };
>  
> -- 
> 2.44.0.278.ge034bb2e1d-goog
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

