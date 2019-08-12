Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0AD38A0E9
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Aug 2019 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfHLOX3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Aug 2019 10:23:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45166 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfHLOX3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Aug 2019 10:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XLXy5S6p+I/2A8akW/h1gdhEnBPAglwE5FN8VuBfBBc=; b=dWj7wlsVGW29mKZm/4mdBDOxt
        Nuzpily3rrIllScvpW9Oyn6sGjlPQ21qphF6RMtijyf2Vzi2G273Tq40+b6j1O9UxvmD1+AfGVY9l
        kmLaj1gZOzDd8ztjnQXtunHlouzl2rrH23RePznjWJAS7V+QIxWonCydlyTS0x1TFG2xx06Ov9rIi
        u26EZTJRWH0lseOrhVrPzJxyjDXeiKQnxIJHpmqIuyh52f8y4joN6WeoYdkreouksof3igISxQxIo
        0ZT+WTWXsDMxGCPcizWYAoS75y+5bE0co3MfT9LL6j7M8d9hnr0IEM6uCxkhvqjsgKYEsSQyCrNRO
        C1Z7dh2RQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBEO-00037m-ML; Mon, 12 Aug 2019 14:23:28 +0000
Date:   Mon, 12 Aug 2019 07:23:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, hare@suse.de, bvanassche@acm.org
Subject: Re: [PATCH v3 05/20] sg: bitops in sg_device
Message-ID: <20190812142328.GE8105@infradead.org>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <20190807114252.2565-6-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807114252.2565-6-dgilbert@interlog.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Aug 07, 2019 at 01:42:37PM +0200, Douglas Gilbert wrote:
> +	unsigned long fdev_bm[1];	/* see SG_FDEV_* defines above */

No need for the array of one here.

> +#define SG_IS_DETACHING(sdp) test_bit(SG_FDEV_DETACHING, (sdp)->fdev_bm)
> +#define SG_HAVE_EXCLUDE(sdp) test_bit(SG_FDEV_EXCLUDE, (sdp)->fdev_bm)

No real need for these wrappers.

Otherwise this looks sane to me.
