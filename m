Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5F815B66F
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Feb 2020 02:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgBMBOS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Feb 2020 20:14:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60294 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbgBMBOS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 Feb 2020 20:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=40jqweQ0+u8pWGs2sdI8o9uT1jQxm85/IXkuAtgtunw=; b=QjvWVM1qZ/x/JEEUG2pL57qNTo
        Vm16OcSWQFsgTWE7GZBtv6918KJGUZHTrodCRERy0oJbPGMbJLt0YdVl3+39ECVz84fVeM9dizjPD
        wFGUZuU2fGGhcbsmaJ1ZdTW3/25sCg+C+TwNlqitZ6NZvrtBT+Rxow4+q2EJ1u92X87umBI6VxfKO
        K3uF34Otz32Swt+xQUX9n58RV6hrpeSAshymyz8XvNSN4d9d/z5l5mnA3syylQsVMAs/HympjxQoU
        tzX43QmNP/UlaSz7UU2g/O7yhI64SFPd9YNC1F9DT1Df3D4W7mkC7dlF7zSGxFUp9UyYXBcJoyNQl
        RmyGooZw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j234w-0004vu-8o; Thu, 13 Feb 2020 01:14:06 +0000
Date:   Wed, 12 Feb 2020 17:14:06 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: advansys: Replace zero-length array with
 flexible-array member
Message-ID: <20200213011406.GI7778@bombadil.infradead.org>
References: <20200213000211.GA23171@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213000211.GA23171@embeddedor.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Feb 12, 2020 at 06:02:11PM -0600, Gustavo A. R. Silva wrote:
> Also, notice that, dynamic memory allocations won't be affected by
> this change:

Shouldn't you also convert this:
                asc_sg_head = kzalloc(sizeof(asc_scsi_q->sg_head) +
                        use_sg * sizeof(struct asc_sg_list), GFP_ATOMIC);
to use struct_size()?

