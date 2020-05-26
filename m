Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85371E248F
	for <lists+linux-scsi@lfdr.de>; Tue, 26 May 2020 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgEZOxo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 May 2020 10:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgEZOxo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 26 May 2020 10:53:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F13C03E96D;
        Tue, 26 May 2020 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4CjAmi30LAVB8ETLdMsuowaxBjBIdLdRt5GpwP/DM6w=; b=fu+G1VUNChJfi1lQIbdOx0911I
        Cy/RGHaEEwn+z7tK6qvQ2+JOjretTS8U2TsxU653Iovr8Qbe3BX8QLr3cOSZRIYFxmXqtqFW52P7E
        SEO96XrFf0srLLk07JjbKkxe0EjTovpGgXkkLy8lDUHFqEaKixYq2ih7CwIOlx+hYEssvz7nQZerg
        9TTPp/3uR79vLVQxpC5tn81D4VsVLiPvj173NMGqb8zfqOTB5nH52Z3Pdv2ycyfDpH1Cw0zKdV0ai
        fNgXQHNea+UYoSf5jGC37y1HubpK7D791wyL/dM26HMk/MqVRuJYfqV81nPCqkhVJdqD5fPEbQlSZ
        HKl5OsCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdaxa-0001E7-RR; Tue, 26 May 2020 14:53:42 +0000
Date:   Tue, 26 May 2020 07:53:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-nvme@lists.infradead.org, axboe@kernel.dk,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, kernel-janitors@vger.kernel.org,
        hch@infradead.org, paul.ely@broadcom.com, hare@suse.de,
        dan.carpenter@oracle.com
Subject: Re: [PATCH 0/3] lpfc: Fix errors in LS receive refactoring
Message-ID: <20200526145342.GA4348@infradead.org>
References: <20200520185929.48779-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520185929.48779-1-jsmart2021@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Thanks,

applied to nvme-5.8.
