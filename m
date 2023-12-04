Return-Path: <linux-scsi+bounces-484-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED65802D4D
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 09:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E062D1C209C4
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CA114F81
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 08:36:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7B1BB
	for <linux-scsi@vger.kernel.org>; Mon,  4 Dec 2023 00:04:29 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0CF9A68AFE; Mon,  4 Dec 2023 09:04:26 +0100 (CET)
Date: Mon, 4 Dec 2023 09:04:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: hare@kernel.org
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] libfc: don't schedule abort twice
Message-ID: <20231204080425.GA30417@lst.de>
References: <20231129165832.224100-1-hare@kernel.org> <20231129165832.224100-2-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129165832.224100-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

