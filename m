Return-Path: <linux-scsi+bounces-707-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D2980907B
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 19:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6881F2128D
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 18:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE474E638
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Dec 2023 18:46:42 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911BE10F7;
	Thu,  7 Dec 2023 09:46:21 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5A17B227A87; Thu,  7 Dec 2023 18:46:18 +0100 (CET)
Date: Thu, 7 Dec 2023 18:46:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Dave Chinner <dchinner@redhat.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5 04/17] fs: Restore F_[GS]ET_FILE_RW_HINT support
Message-ID: <20231207174617.GD31184@lst.de>
References: <20231130013322.175290-1-bvanassche@acm.org> <20231130013322.175290-5-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130013322.175290-5-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 29, 2023 at 05:33:09PM -0800, Bart Van Assche wrote:
> Revert commit 7b12e49669c9 ("fs: remove fs.f_write_hint") to enable testing
> write hint support with fio and direct I/O.

To enable testing seems like a pretty bad argument for bloating struct
file.  I'd much prefer to not restore it, but if you want to do so
please write a convincing commit log.

