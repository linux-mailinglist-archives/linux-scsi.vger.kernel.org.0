Return-Path: <linux-scsi+bounces-1458-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C126826963
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jan 2024 09:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7391F21E15
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Jan 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B770B673;
	Mon,  8 Jan 2024 08:24:58 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA19B65E;
	Mon,  8 Jan 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B117268AFE; Mon,  8 Jan 2024 09:24:52 +0100 (CET)
Date: Mon, 8 Jan 2024 09:24:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: Re: remove another host aware model leftover
Message-ID: <20240108082452.GA4517@lst.de>
References: <20231228075141.362560-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228075141.362560-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Jens, Martin,

can you take a look at this?  It would be great to finish the zone
aware removal fully with this for 6.8.  Thanks!


