Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854621B37A7
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2020 08:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDVGly (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Apr 2020 02:41:54 -0400
Received: from verein.lst.de ([213.95.11.211]:50470 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgDVGly (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 22 Apr 2020 02:41:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CE82E68C7B; Wed, 22 Apr 2020 08:41:51 +0200 (CEST)
Date:   Wed, 22 Apr 2020 08:41:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: clean up DMA draining
Message-ID: <20200422064151.GA23271@lst.de>
References: <20200414074225.332324-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414074225.332324-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Apr 14, 2020 at 09:42:20AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> currently the dma draining and alignining specific to ATA CDROMs
> and the UFS driver has its ugly hooks in core block code.  Move
> this out into the scsi and ide drivers instead.

Any commens?
