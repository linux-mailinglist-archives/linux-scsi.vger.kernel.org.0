Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B647C588D
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Oct 2023 17:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346956AbjJKPvK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Oct 2023 11:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346473AbjJKPvI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 11 Oct 2023 11:51:08 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F090AB6
        for <linux-scsi@vger.kernel.org>; Wed, 11 Oct 2023 08:51:06 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59b5484fbe6so86574787b3.1
        for <linux-scsi@vger.kernel.org>; Wed, 11 Oct 2023 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697039466; x=1697644266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgcAwPpGflvmi9WCtQQxqQtojLLfUAZnyJlHIKQ5SQM=;
        b=Zp8PAWPaP9210FGYjUSUBbJua24lF+xM6qjBJi+NyIiRGl3p5tBo9DAb317FhMuSGV
         1WPh3qvW+7Ve0HmesQ2btRNJqgj7ml2MbRsWUSXopFZyHJPFV9jHrjrfT3sv5XhRA+Ve
         QviRJVtwEw1767utITJxyDdziIIIVMSyvEN1PcUoUBSK1kMGzUYs3FWUTr9nOnrg8UBi
         B1hmKse9BzSeVgAto8mMQ0ASHPvcLEASJoywYy5wXOfHrgpkE5MBDbPgmhVg6St9R4VQ
         uFSU4NTSar7vQ9Bejve65OoLLEhY9w+5t8v6FyJCDKr5uyykJrrYGDUGLoOMN1OT4SEm
         LosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039466; x=1697644266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgcAwPpGflvmi9WCtQQxqQtojLLfUAZnyJlHIKQ5SQM=;
        b=IemGXjgjxLVt2/eY30G6bez8sN04NxDMjROs+/n1aDDiT7cr+f6wMV2pZmni/lCgmL
         VnCMXobqI0fEjrfxnusaUbFP2LgGbvOhV8sDNNxzRCys7r8rkUlb4l6PZn9l0bsfs2e8
         dTvEplH6TMLGtgPQVWwFJEJ98g3lJHXcU+WdCxZucK8p1LciYdaDK7/aDFXkbFiwWLpR
         NOFnLc3xOD9OkRSdJf0vR3oFZGwk1JzqgqaoG7PSLQw/uNSWMPt6B3FsQKXagRrnIVjB
         Dv48m7u/7p62YVc2kf58KA9x64h1fPKfntOoilqHO04OiWvqYTG9Mh2Glvzaabt6TRau
         nsYw==
X-Gm-Message-State: AOJu0YyB2s9hDQYT+/i+8UhZNFF3LDThV7e3AwWlkfGMCEtGtkJU+EWl
        shFNvgCgY8O7I21UNcyDIAQZa81C5XlK6O6VOhw=
X-Google-Smtp-Source: AGHT+IExCLOrDbvUCQHHyRtGD33zPEyYOMQtEdS2uMpns4tw/aL9bNEKOSkZehzFBhECNWfYvF/2MA==
X-Received: by 2002:a0d:d802:0:b0:5a7:be29:19ac with SMTP id a2-20020a0dd802000000b005a7be2919acmr5927670ywe.12.1697039466164;
        Wed, 11 Oct 2023 08:51:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id v11-20020a05620a122b00b0076f1d8b1c2dsm5312568qkj.12.2023.10.11.08.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:51:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qqbUG-000hJ7-TJ;
        Wed, 11 Oct 2023 12:51:04 -0300
Date:   Wed, 11 Oct 2023 12:51:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Zhu Yanjun' <yanjun.zhu@linux.dev>,
        Leon Romanovsky <leon@kernel.org>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Zhu Yanjun <yanjun.zhu@intel.com>
Subject: Re: [PATCH 1/1] Revert "RDMA/rxe: Add workqueue support for rxe
 tasks"
Message-ID: <20231011155104.GF55194@ziepe.ca>
References: <2fcef3c8-808e-8e6a-b23d-9f1b3f98c1f9@linux.dev>
 <552f2342-e800-43bc-b859-d73297ce940f@acm.org>
 <20231004183824.GQ13795@ziepe.ca>
 <c0665377-d2be-e4b6-3d25-727ef303d26e@linux.dev>
 <20231005142148.GA970053@ziepe.ca>
 <6a730dad-9d81-46d9-8adc-764d00745b01@acm.org>
 <a8453889-3f5f-49ff-89f2-ec0ef929d915@linux.dev>
 <OS3PR01MB9865F9BEB1A90DDCAEEBFC8BE5CDA@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20231010160919.GC55194@ziepe.ca>
 <a4808fa6-5bd5-4a64-a437-6a7e89ca7e9f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4808fa6-5bd5-4a64-a437-6a7e89ca7e9f@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Oct 10, 2023 at 02:29:19PM -0700, Bart Van Assche wrote:
> On 10/10/23 09:09, Jason Gunthorpe wrote:
> > On Tue, Oct 10, 2023 at 04:53:55AM +0000, Daisuke Matsuda (Fujitsu) wrote:
> > 
> > > Solution 1: Reverting "RDMA/rxe: Add workqueue support for rxe tasks"
> > > I see this is supported by Zhu, Bart and approved by Leon.
> > > 
> > > Solution 2: Serializing execution of work items
> > > > -       rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> > > > +       rxe_wq = alloc_workqueue("rxe_wq", WQ_HIGHPRI | WQ_UNBOUND, 1);
> > > 
> > > Solution 3: Merging requester and completer (not yet submitted/tested)
> > > https://lore.kernel.org/all/93c8ad67-f008-4352-8887-099723c2f4ec@gmail.com/
> > > Not clear to me if we should call this a new feature or a fix.
> > > If it can eliminate the hang issue, it could be an ultimate solution.
> > > 
> > > It is understandable some people do not want to wait for solution 3 to be submitted and verified.
> > > Is there any problem if we adopt solution 2?
> > > If so, then I agree to going with solution 1.
> > > If not, solution 2 is better to me.
> > 
> > I also do not want to go backwards, I don't believe the locking is
> > magically correct under tasklets. 2 is painful enough to continue to
> > motivate people to fix this while unbreaking block tests.
> 
> In my opinion (2) is not a solution. Zhu Yanjun reported test failures with
> rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, 1). Adding WQ_HIGHPRI probably
> made it less likely to trigger any race conditions but I don't believe that
> this is sufficient as a solution.

I've been going on the assumption that rxe has always been full of
bugs. I don't believe the work queue change added new bugs, it just
made the existing bugs easier to hit.

It is hard to be sure until someon can find out what is going wrong.

If we revert it then rxe will probably just stop development
entirely. Daisuke's ODP work will be blocked and if Bob was able to
fix it he would have done so already. Which mean's Bobs ongoing work
is lost too.

I *vastly* prefer we root cause and fix it properly. Rxe was finally
starting to get a reasonable set of people interested in it, I do not
want to kill that off.

Again, I'm troubled that this doesn't seem to be reproducing for other
people.

> > I'm still puzzled why Bob can't reproduce the things Bart has seen.
> 
> Is this necessary?

It is always easier to debug something you can change than to try and
guess what an oops is trying to say..

> The KASAN complaint that I reported should be more than enough for
> someone who is familiar with the RXE driver to identify and fix the
> root cause. I can help with testing candidate fixes.

Bob?

Jason
