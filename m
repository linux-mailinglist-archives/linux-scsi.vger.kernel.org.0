Return-Path: <linux-scsi+bounces-483-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3423802D4C
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 09:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F00E1C209DD
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEA8F9D6
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 08:36:23 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF0A129;
	Sun,  3 Dec 2023 23:52:55 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 868B5227A8E; Mon,  4 Dec 2023 08:52:52 +0100 (CET)
Date: Mon, 4 Dec 2023 08:52:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 0/6] Disable fair tag sharing for UFS devices
Message-ID: <20231204075252.GA29579@lst.de>
References: <20231130193139.880955-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130193139.880955-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 30, 2023 at 11:31:27AM -0800, Bart Van Assche wrote:
> Hi Jens,
> 
> The fair tag sharing algorithm reduces performance for UFS devices
> significantly. This is because UFS devices have multiple logical units, a
> limited queue depth (32 for UFS 3.1 devices), because it happens often that
> multiple logical units are accessed and also because it takes time to
> give tags back after activity on a request queue has stopped. This patch series
> restores UFS device performance to that of the legacy block layer by disabling
> fair tag sharing for UFS devices.

I feel like a broken record:

fair tag sharing exists for a reason.  Opting out of it for a specific
driver does not make any sense.  Either you can make a good argument
why you don't want it at all, or for specific configurations you
can clearly explain, or you make it work faster.  A "treat my driver
special" flag is never acceptable.

