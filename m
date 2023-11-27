Return-Path: <linux-scsi+bounces-193-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 462EC7F9BE1
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Nov 2023 09:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AB2280D89
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Nov 2023 08:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAFA171C8
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Nov 2023 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA601FF6;
	Sun, 26 Nov 2023 23:09:42 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B7CF7227A87; Mon, 27 Nov 2023 08:09:39 +0100 (CET)
Date: Mon, 27 Nov 2023 08:09:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v15 00/19] Improve =?utf-8?Q?wr?=
 =?utf-8?Q?ite_performance_for_zoned_UFS_devices=E2=80=8B?=
Message-ID: <20231127070939.GB27870@lst.de>
References: <20231114211804.1449162-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114211804.1449162-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

As this keeps getting reposted:

I still think it is a very bad idea to add this amount of complexity to
the SCSI code, for a model that can't work for the general case and
diverges from the established NVMe model.

So I do not thing we should support this.


