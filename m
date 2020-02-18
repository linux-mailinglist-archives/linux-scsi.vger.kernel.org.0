Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7745C163743
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Feb 2020 00:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgBRXcX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Feb 2020 18:32:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgBRXcW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Feb 2020 18:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xBaBg5nhS9IXA1XeeXo39ZB3oq+psdy9RzGB5qqGr0I=; b=uEVB7aFY1V1GPlrgoeNB700oXs
        DqmL+K9B6L3QxGVCeg7evzgriebA4INltI4t6Fez9xfL5Fx0gzwc49LTkTSjiGw3/5Nm0n5bh4W+p
        wtAp82V1PWCUA8UsmWM2ztrQu6YD9JXmviWS+IbOh70T2lkHcJEI2KH7tEmufbp6seXEx4JUn4ZpV
        leSj1nB8cdKbpUSXNUEmd0KaYdQBUMWYjjy/i8CqRfe0C5irDJrJl9vu5mCkrwypEwNFxzExjJ5Dz
        /tqe416ZZ9foivOBUFnC8WbUPmoujU3nSKvmrAR79mMn8xppDaokN2mJXIxG5SGgrnSNwgXeRpPxF
        /IHxfPZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4CLm-0001rD-1d; Tue, 18 Feb 2020 23:32:22 +0000
Date:   Tue, 18 Feb 2020 15:32:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Subject: Re: [PATCH] ufs: add quirk to fix abnormal ocs fatal error
Message-ID: <20200218233222.GA6827@infradead.org>
References: <CGME20200218224503epcas2p46cec6f56d7564ea7dca4ab600476d938@epcas2p4.samsung.com>
 <20200218224307.8017-1-kwmad.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218224307.8017-1-kwmad.kim@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Feb 19, 2020 at 07:43:07AM +0900, Kiwoong Kim wrote:
> Some architectures determines if fatal error for OCS
> occurrs to check status in response upiu. This patch
> is to prevent from reporting command results with that.

This seems to be missing the hunk to actually set the quirk bit..
