Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 886CE8A0E6
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Aug 2019 16:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfHLOXN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Aug 2019 10:23:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfHLOXN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Aug 2019 10:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JC9bjRjuIitXlaEbE5ucjUB4Dfb3oO6G8MrnTPUb1J4=; b=lX5ak2XqD+ggQsKs9z4THC9og
        dS2wUYhSN+GT7/ohMUSb+MG7LIvfrHMTOcd1m8m+fjXM/XvN8AiPJhRtTv+FPByBbLtflmRRMcrQp
        w4QRF2mrNHrRXRfXvrbkTnM1bMcjAkwOrmU64upy5a2OQfnM19Ts1ipTVyP4m6GusGGf9TNYsXQyV
        O3HWf1zfTWfSjqT/PARL6B5LyZLQ/GNESrUoRlmfMOvz/7yDxhQFlPZz72rjE/pAvfH+r6n5Wq8aL
        J4uIhDQWbnOvni0ENGL68k/iBQErRNTN4KrVAlHIEEQCzFgcInGX8oTr5YZmZJKLoo8hoPEOgPajN
        bNZsc2f2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBE8-0002tc-PC; Mon, 12 Aug 2019 14:23:12 +0000
Date:   Mon, 12 Aug 2019 07:23:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, hare@suse.de, bvanassche@acm.org
Subject: Re: [PATCH v3 04/20] sg: rework sg_poll(), minor changes
Message-ID: <20190812142312.GD8105@infradead.org>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <20190807114252.2565-5-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807114252.2565-5-dgilbert@interlog.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Aug 07, 2019 at 01:42:36PM +0200, Douglas Gilbert wrote:
> Re-arrange code in sg_poll(). Rename sg_read_oxfer() to
> sg_rd_append(). In sg_start_req() rename rw to r0w.
> Plus associated changes demanded by checkpatch.pl

r0w seems like a really odd variably name that doesn't help
readability.  Also all these changes seem independent from each
other to me, so they should be split into multiple patches.
