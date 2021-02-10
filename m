Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B124B316143
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Feb 2021 09:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhBJIlc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Feb 2021 03:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhBJIi4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 Feb 2021 03:38:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25DDC06174A;
        Wed, 10 Feb 2021 00:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+qITOZrYF9no2ix1twH+0IKQ9x3nOOUKSCIAW2uGldE=; b=MY0asvwIRHDHQ0ram3Yrv8oNk1
        dSLt8cO/rUXS0U52qUuy2gDw3WrzB6aSVobMHASsXXrYdqKy9CHS5hMjk+Xrp+hfJOCnh30zKYEEC
        /z9Lr8awLTuJ53vgAKKFkmC6IYCrV37DIF5LLBpItqLdwaLjX3ujYOwFVUvlXEEJXpkFMiDBRzNuQ
        j7SRaaFsargX/QngCdI30a8UA9JJduYM7K771DaUhGFmpuBF1yg13P+fGpmgrgpasnMMxKlI0vhvz
        54NJ2ceLmNgW8kpDmeTcxstUK/i8sWfZsmzLdWscptZHO9pWyzzog+64jeoadEpDD2P8EvMHgMsR7
        vOxJb4Zg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l9l0i-008anH-7V; Wed, 10 Feb 2021 08:38:08 +0000
Date:   Wed, 10 Feb 2021 08:38:08 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Chaitanya.Kulkarni@wdc.com, loberman@redhat.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, mst@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 07/13] target: cleanup cmd flag bits
Message-ID: <20210210083808.GD2045726@infradead.org>
References: <20210209123845.4856-1-michael.christie@oracle.com>
 <20210209123845.4856-8-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209123845.4856-8-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Feb 09, 2021 at 06:38:39AM -0600, Mike Christie wrote:
> We have a couple holes in the cmd flags definitions. This cleans
> up the definitions to fix that and make it easier to read.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
