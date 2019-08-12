Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF98A0EA
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Aug 2019 16:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfHLOX6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Aug 2019 10:23:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47222 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfHLOX6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Aug 2019 10:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Mpiy7mwk6pWGZ4cjoOZiMeptjAIIXY3hr1rdp+2fnQ=; b=lALzR92g1bN3OdpwwJiHoDpeO
        j7SyRHlXisca7bienDLYW5s/6CTmCFtABWjJhnm1UGmRyauhqXg7jExbP5TNpNQtcXNb/Rk4hLrzW
        84Lgj4/hPr9iOuuwisEPWRZGtba4Xn7xPD+uVc9Vu+tTOOWwRRkEmY7bLEoEG1jewl8h6JM8hpjFw
        86Uv4o15yPqePz7yPVgXVMz+bmlFToS04yo+FSFmQd3e8kVcxvrh2GYe9PS/yClH3Vy81AP/A3O11
        7qIk9hmPCq3QaP3M2nele82jFqTw5DNbluP4mWCKQ24jYE8OTfrN57MBH9We7beeau/1lIEmV1RYv
        U770pkuOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBEs-0003UA-8D; Mon, 12 Aug 2019 14:23:58 +0000
Date:   Mon, 12 Aug 2019 07:23:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        jejb@linux.vnet.ibm.com, hare@suse.de, bvanassche@acm.org
Subject: Re: [PATCH v3 06/20] sg: make open count an atomic
Message-ID: <20190812142358.GF8105@infradead.org>
References: <20190807114252.2565-1-dgilbert@interlog.com>
 <20190807114252.2565-7-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807114252.2565-7-dgilbert@interlog.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Aug 07, 2019 at 01:42:38PM +0200, Douglas Gilbert wrote:
> Convert sg_device::open_cnt into an atomic. Also rename
> sg_tablesize into the more descriptive max_sgat_elems.

These are two unrelated changes that should be split.  Both look ok
to me individually.
