Return-Path: <linux-scsi+bounces-5788-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA0F908F8E
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2024 18:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17E41F21BA1
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Jun 2024 16:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5119F180A79;
	Fri, 14 Jun 2024 16:03:33 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F29F17FAC5;
	Fri, 14 Jun 2024 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381013; cv=none; b=mWS3PNHb7/EVqtscY/0wVWHCnBU6SODLZBKgJN1Bb5o+b0wBMTNYE25DQSd6Ujau7vQbbxooPJE+NugFevdKo5XRPcFeuPluVkXxId/VWWnBXiNhR5acnQcyqDil9vtF4m3JTzzalrqC0hcKd/Ca2UtSdFjssCadwS2B7LvPTMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381013; c=relaxed/simple;
	bh=y9KHOvoliQVhwac/rD6nLgSGHo9c8nOF6OxAfdCQZyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jc/YskjZOqzEFenvrlrFEwIIsHQv4l+PNgI02Mf0TKB4w2VDlNyFw/K2BR963wbJ//7YOqsIhxmkW/gNnPtiS7mCMBoSgFE99t32DHrZ5Vy2u3PTpyXqBga+gnsaYL23tzV0ys/xPdFe5PQD9arwhADT864TrEjNwFUOU9RdoTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7D45068CFE; Fri, 14 Jun 2024 18:03:22 +0200 (CEST)
Date: Fri, 14 Jun 2024 18:03:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: Re: move integrity settings to queue_limits v3
Message-ID: <20240614160322.GA16649@lst.de>
References: <20240613084839.1044015-1-hch@lst.de> <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 14, 2024 at 06:33:41AM -0600, Jens Axboe wrote:
> > The series is based on top of my previously sent "convert the SCSI ULDs
> > to the atomic queue limits API v2" API.
> 
> I was going to queue this up, but:
> 
> drivers/scsi/sd.c: In function ‘sd_revalidate_disk’:
> drivers/scsi/sd.c:3658:45: error: ‘lim’ undeclared (first use in this function)
>  3658 |                 sd_config_protection(sdkp, &lim);
>       |                                             ^~~
> drivers/scsi/sd.c:3658:45: note: each undeclared identifier is reported only once for each function it appears in

That sounds like you didn't apply the above mentioned
"convert the SCSI ULDs to the atomic queue limits API v2" series before?


