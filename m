Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BC5162BCE
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Feb 2020 18:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgBRRNB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Feb 2020 12:13:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51016 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgBRRNB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Feb 2020 12:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n83rleAnito6jfYSkWr8X9NF/FPLJL8j7d75hLxiOSk=; b=cMe5mA+eqHIGzUhxkEz0zsc1Um
        0EJohCoPSicsQKtFXzYOjI/A8kCR30ryms2DTh+oeZe7uT64qyno3XTcdiFmpT2pmDRPF1pofJohq
        9vpDgFaA3K1sg7o5bPjVIuoeS3HYbIzySmHvcj2cXQkGRTBUJDdSYTuM4x7KrV2Svg1BmifugLZS5
        GB33gJ1AVZczhRILxqkP0mhXw+kaKAKALQyGLewkJ4aklg2cGfUqkTGwHOSGkj9RETOdhZFUKAdQE
        in6UFhCUJpszSHzlaQeECX7DT8SP1tsMxGNxy36GTslPP9S9G5N19mQZUDws/55yEkSKpgYDRfQrz
        uS0ZGYCQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j46Qd-0001pq-Qg; Tue, 18 Feb 2020 17:12:59 +0000
Date:   Tue, 18 Feb 2020 09:12:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Merlijn Wajer <merlijn@archive.org>
Cc:     merlijn@wizzup.org, linux-scsi@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: sr: get rid of sr global mutex
Message-ID: <20200218171259.GA6724@infradead.org>
References: <20200218143918.30267-1-merlijn@archive.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218143918.30267-1-merlijn@archive.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Feb 18, 2020 at 03:39:17PM +0100, Merlijn Wajer wrote:
> When replacing the Big Kernel Lock in commit
> 2a48fc0ab24241755dc93bfd4f01d68efab47f5a ("block: autoconvert trivial
> BKL users to private mutex"), the lock was replaced with a sr-wide lock.
> 
> This causes very poor performance when using multiple sr devices, as the
> sr driver was not able to execute more than one command to one drive at
> any given time, even when there were many CD drives available.
> 
> Replace the global mutex with per-sr-device mutex.

Do we actually need the lock at all?  What is protected by it?
