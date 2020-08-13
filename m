Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7DD2434F0
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Aug 2020 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgHMH2Z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Aug 2020 03:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHMH2X (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 13 Aug 2020 03:28:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43426C061757
        for <linux-scsi@vger.kernel.org>; Thu, 13 Aug 2020 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r2nUUwYe6yjLw9yvSbNAfvHKZx8LoR9irgcPudfPUhg=; b=ASSE+cRdMftIeBG3pzkI3B2KfO
        zOtQSiOyEXh+wrh6Wf8sVbgvF48unPu1diwkKex1aPnGRTtn94JKiqohu8GZt6fjIph6VryqsJ8kz
        fRM9pfdGbzCay+dy5ILlOaYN5qGz4cq2AYVrIw58fFe1ByyM6fRUsOEpwG2V7CUPYaZ034CPLEHnw
        7rb47RNtuB3KLm8vT5ESXA94A/yCM4q0F6qCZGUe+zU51R/zNehzbLJxQ7zzFoZWMoOBrQB9xxWOE
        bey5guI6uyIK4FAO37R7dPI2+3QCYxgAnwr+7nP2wmO08FFy/4QasVV9P0voQhqhabzG4LTmpVsVb
        LjpkU/4g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k67er-0003yH-R1; Thu, 13 Aug 2020 07:28:17 +0000
Date:   Thu, 13 Aug 2020 08:28:17 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jim Gill <jgill@vmware.com>
Cc:     pv-drivers@vmware.com, jejb@linux.ibj.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/3 for-next] pvscsi: Use coherent memory instead of dma
 mapping sg lists
Message-ID: <20200813072817.GB14861@infradead.org>
References: <20200812205404.GA17846@petr-dev3.eng.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812205404.GA17846@petr-dev3.eng.vmware.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Aug 12, 2020 at 01:54:04PM -0700, Jim Gill wrote:
> Use coherent memory instead of dma mapping sg lists each
> time they are used. This becomes important with SEV/swiotlb where
> dma mapping otherwise implies bouncing of the data. It also gets rid
> of a point of potential failure.
> 
> Tested using a "bonnie++" run on an 8GB pvscsi disk on a swiotlb=force
> booted kernel.

This is the wrong way around.  allocations from the coherent pool put
the system under a pointless constrained on architectures that aren't
dma coherent.  Please don't do that.
