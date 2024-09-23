Return-Path: <linux-scsi+bounces-8350-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3D1979B76
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Sep 2024 08:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7723A1F232EB
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Sep 2024 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D7D7D3F1;
	Mon, 16 Sep 2024 06:48:54 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBCA5025E;
	Mon, 16 Sep 2024 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469334; cv=none; b=hPVpkTPBovVWa1QCazO+ILFmSlcdA5U54bfSSfX9lTythGL8burZTmT/2z/SgWMwQnfHi8FrbSKLQmzgAoFo+Zu6jVR49Ag2fH7JarIxjx2HP896apI5GskN07fdt7zEy6fqy7s21NDEVeGWSEP3v3NR6wOsPBj6B2qLvwWo58Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469334; c=relaxed/simple;
	bh=y8BURP73rNIkllDOPgxsGnvJZjK9VISFdAoxhnkEplA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSQcWloKH2tfilmOru9h3o56CjzjwgQyzkjsJEGS2l9YDueLlEEX9QVxbs7kZqlK98x0fDOA7geeY4gWCTWngQiL7v0KzRbHGxy3AKhaDz7yIY3rbBvovNbhaoiLcFYqt+6lFtT24EiNXFH10X4pFnI5ZVDbeEylme/BDfU92YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92036227AAA; Mon, 16 Sep 2024 08:48:46 +0200 (CEST)
Date: Mon, 16 Sep 2024 08:48:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
	20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de,
	Ming Lei <ming.lei@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <20240916064846.GA15950@lst.de>
References: <20240913-refactor-blk-affinity-helpers-v1-1-8e058f77af12@suse.de> <20240913162654.GA713813@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913162654.GA713813@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Sep 13, 2024 at 11:26:54AM -0500, Bjorn Helgaas wrote:
> > +const struct cpumask *pci_get_blk_mq_affinity(void *dev_data, int offset,
> > +					      int queue)
> > +{
> > +	struct pci_dev *pdev = dev_data;
> > +
> > +	return pci_irq_get_affinity(pdev, offset + queue);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_get_blk_mq_affinity);
> > +#endif
> 
> IMO this doesn't really fit well in drivers/pci since it doesn't add
> any PCI-specific knowledge or require any PCI core internals, and the
> parameters are blk-specific.  I don't object to the code, but it seems
> like it could go somewhere in block/?

That's where it, or rather the current equivalent, lives, which is a bit
silly.  That being said, I suspect the nicest thing would be to offer a
real irq_get_affinity interface at the bus level.

e.g. add something like:


	const struct cpumask *(*irq_get_affinity(struct device *dev,
			unsigned int irq_vec);

to struct bus_type so that any layer can just query the irq affinity
for buses that support it without extra glue code.

