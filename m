Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8622B0211
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Nov 2020 10:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKLJiD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 Nov 2020 04:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgKLJiC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 Nov 2020 04:38:02 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92295C0613D1;
        Thu, 12 Nov 2020 01:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cnWNfTHVU4AEXtUdky7SzwT/9uPYUSiJsLa4+lGu8a8=; b=TS+osSOLMCGS4fDhHQTgjKOJng
        BYlhxXc3gLOHA83cYAk937kLntXcC6InGwuROC6f3+DNXtadbsoCtWKcuJq+4QHBcbLIDJXRnhv3O
        TgwYa19YZrdoay+00fILS+4mXPV1zn86DlTvKunG6818dlenu1z6R3vqxPitwFciMy3bGiQGufPJV
        f85noQ79w/nqcaXyIVlVKqbi3tUtgKvqyDQXPbTV+4lGzFZl0h/X1Ata7YI/5k7OM45eG+xWULmyy
        Ae6xOmkLS4xDI8cDZW7qMIiesvh1sXT1IzJFPRfrYe107Ic/sVtMZqYTGKf16h6YLtppwPKFPMdAy
        wnh82Y0g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kd93A-0006O5-8p; Thu, 12 Nov 2020 09:37:52 +0000
Date:   Thu, 12 Nov 2020 09:37:52 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/6] ibmvfc: byte swap login_buf.resp values in attribute
 show functions
Message-ID: <20201112093752.GA24235@infradead.org>
References: <20201112010442.102589-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112010442.102589-1-tyreld@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Nov 11, 2020 at 07:04:37PM -0600, Tyrel Datwyler wrote:
> Both ibmvfc_show_host_(capabilities|npiv_version) functions retrieve
> values from vhost->login_buf.resp buffer. This is the MAD response
> buffer from the VIOS and as such any multi-byte non-string values are in
> big endian format.
> 
> Byte swap these values to host cpu endian format for better human
> readability.

The whole series creates tons of pointlessly over 80 char lines.
Please do a quick fixup.
