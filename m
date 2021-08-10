Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C97C3E7E30
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 19:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhHJR04 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Aug 2021 13:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhHJR0z (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 10 Aug 2021 13:26:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8176AC0613C1
        for <linux-scsi@vger.kernel.org>; Tue, 10 Aug 2021 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qcongcVP5BwOByrsqx33B0aZPY/1xSlNBT4Z8ee29sU=; b=ewFPMxxsxAWxw3J+AU/H1PIuGf
        Hfn8fGa9hrT0w855iOiEdwf/cxgU0rtEWwkAVZy9/w7QxLLhlgKwCRlkXxFvGwsP1CwVmWKrZuyMM
        LDcZJNbFSywkvGQwEdjG0HGZ8QjXVRvMSFBupecPpdpf+sYavfHP8tNzFIdTNlrG1AtJcwg8/+Ucs
        /e31m+e9440B96WQgxKoyxlSfq1EgsEe5M1LqdgO6e1Tcs5U0GCzJcUO6RT0UViCsV6v1hSP9utGz
        HNXQAfaSDUCjhXufpSPXVvzj8ocdxZwMO0oZ0i7+AGt9MBb/ZIjClkPSql+anx7X2rDXXWL9zKKN5
        e0OMnNzw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDVVE-00COec-7L; Tue, 10 Aug 2021 17:25:34 +0000
Date:   Tue, 10 Aug 2021 18:25:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH v5 14/52] advansys: Use scsi_cmd_to_rq() instead of
 scsi_cmnd.request
Message-ID: <YRK2hKugp+4thBJt@casper.infradead.org>
References: <20210809230355.8186-1-bvanassche@acm.org>
 <20210809230355.8186-15-bvanassche@acm.org>
 <b4dd9bf7-1d4b-9a09-2100-dcf0c3aeb434@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4dd9bf7-1d4b-9a09-2100-dcf0c3aeb434@suse.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Aug 10, 2021 at 08:25:16AM +0200, Hannes Reinecke wrote:
> > +	srb_tag = scsi_cmd_to_rq(scp)->tag + 1;
> Cf the previous patch; we really should introduce a helper to get the tag
> from a SCSI command.

scsi_cmd_tag(scp) ?
