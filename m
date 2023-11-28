Return-Path: <linux-scsi+bounces-268-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E177FBCF3
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Nov 2023 15:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921B52817B0
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Nov 2023 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96E405C6
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Nov 2023 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3D8D72;
	Tue, 28 Nov 2023 04:53:59 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 72A28227A87; Tue, 28 Nov 2023 13:53:55 +0100 (CET)
Date: Tue, 28 Nov 2023 13:53:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v15 00/19] Improve write performance for zoned UFS
 devices
Message-ID: <20231128125355.GA7613@lst.de>
References: <20231114211804.1449162-1-bvanassche@acm.org> <20231127070939.GB27870@lst.de> <a9748872-0608-4ab9-8986-a82eff17ca9f@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9748872-0608-4ab9-8986-a82eff17ca9f@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 27, 2023 at 11:35:48AM -0800, Bart Van Assche wrote:
> Here is some additional background information:

I know the background.  I also know that JEDEC did all this aginst
better judgement and knowing the situation.  We should not give them
their carrot after they haven't even been interested in engaging.


