Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8719F34914
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfFDNkI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 09:40:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34701 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfFDNkI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 09:40:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so3924093pfc.1
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rXkfcFUyOyTS2BvPRCp/X0+JX/4MtGFmasht8Xpe9so=;
        b=CF4dssrDnIUyZkE16+XHQR1k4e/3C7KkkldozV+G/7fmtLJ2WMtKOfRXjg+L1DdXpK
         sP+w3hvGAQEb2vSk1QpWozMyiXpG4faB+XJAvILxpTod5InL0oSmZO1cQ+g37aqRBYqN
         HLmPqapoJB+mnzQtXJqo3RstnWwybN8M91tECP9Ec9N1lqFwBG+voYe/y+1A36cERrYM
         YLQ06Q/AFVQo/yF6tt6HVJIqXzof7dU+osTm0tWoNGHNp7wgQ7VNj+As95xrTMi0eYzQ
         qEE0SyRDJh40kqtQGMsb9caMdg4WET6mTY2Uvb9mTph1HD2L7MbmI7BSRvzo4pgf0Z+0
         1Nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rXkfcFUyOyTS2BvPRCp/X0+JX/4MtGFmasht8Xpe9so=;
        b=X37Cigi41L6eVY4U18/0IHulxB2tqdGaTeWZqGB0h+7K/gWs6TMFn1XUoyFtlSQZPF
         IZZcj3pyoDybmsL1Jqjsq9Bp01tQ0Rr3yWIQ3xrt/KK4pGN9cuZ572d2ngzxWFZUQl9D
         HmYXZfUGfXeoR04BTwQEekqP4eH8irpkqwOBJu/CMcFbWyv+h3PJ/Hwejd/5Otbwtz/O
         VMe2pZeMtsJLwohoSFh01WDK9mxKuGnqQ28nNpYyDifrkfQ6naEDAjANlGTEQFgi//a9
         R26R+zxhEAUtfJ7awVsD5IXFJSGuoyMre9Pm86qDAlZAi/5eNv4iPWzD39EBoWHZXkFQ
         Iw7g==
X-Gm-Message-State: APjAAAUMBnwoD0Ar3uz6TiJXvuroRVqbP/O0nZKv3O4ZPFcvyijQgcpU
        9S0CM+EpuLUQDH6aRwKJrF8=
X-Google-Smtp-Source: APXvYqy0IAHdqdGt7gaoyJg9A2lw/2JkgxYzx5iPtpGrbusoud6mLB6gLIVQ2qcgTX83dIlEhYit8Q==
X-Received: by 2002:a17:90a:cb81:: with SMTP id a1mr11324681pju.81.1559655608066;
        Tue, 04 Jun 2019 06:40:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j186sm17310606pfg.66.2019.06.04.06.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 06:40:07 -0700 (PDT)
Date:   Tue, 4 Jun 2019 06:40:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/2] scsi: core: don't pre-allocate small SGL in case of
 NO_SG_CHAIN
Message-ID: <20190604134006.GC1880@roeck-us.net>
References: <20190604082308.5575-1-ming.lei@redhat.com>
 <20190604082308.5575-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604082308.5575-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 04, 2019 at 04:23:07PM +0800, Ming Lei wrote:
> The pre-allocated small SGL depends on SG_CHAIN, so if the ARCH doesn't
> support SG_CHAIN, pre-allocation of small SGL can't work at all.
> 
> Fixes this issue by not using small pre-allocation in case of
> NO_SG_CHAIN.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Fixes: c3288dd8c232 ("scsi: core: avoid pre-allocating big SGL for data")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

alpha images still crash with this patch applied (see response to
patch 0/2) for traceback).

Guenter
