Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F935B639B
	for <lists+linux-scsi@lfdr.de>; Tue, 13 Sep 2022 00:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiILWVv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Sep 2022 18:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiILWVe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Sep 2022 18:21:34 -0400
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DA6111E
        for <linux-scsi@vger.kernel.org>; Mon, 12 Sep 2022 15:21:33 -0700 (PDT)
Received: from [192.168.126.243] (ip98-164-213-246.oc.oc.cox.net [98.164.213.246])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4MRLfg4wWCzSP7;
        Mon, 12 Sep 2022 18:21:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1663021292; bh=ooIHeWpOxf36Z6mClp+jaLQ73/CW8dm7+vnOnYoZjCw=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=hvowW8cQOmu2uIGm1iO6Au7QBRPQGYNZRJg/rf7SMd00goQpXO6ZL7X2mzmeJI+zH
         S1GYsbXieGyEAw/twgoxMwachNNxMetI/dkrBW2AEkxU0OJ+ITC1OQs/f5VJ6SgA+A
         Dt0WCAQaXai2iO7uYMD3EFVZ71izou3wpdUJo1R0=
Date:   Mon, 12 Sep 2022 15:21:30 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Bart Van Assche <bvanassche@acm.org>
cc:     linux-scsi@vger.kernel.org
Subject: Re: Another DP for Revert "scsi: core: Call blk_mq_free_tag_set()
 earlier"
In-Reply-To: <e1d7dcf5-975e-ef90-fea4-2ca089e97493@acm.org>
Message-ID: <66b7da2b-5753-baee-db5a-a2bc4387354@panix.com>
References: <9dc65f12-7692-7f2f-b3a7-41befb47d9a6@panix.com> <e1d7dcf5-975e-ef90-fea4-2ca089e97493@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


On Mon, 12 Sep 2022, Bart Van Assche wrote:

> Thanks for having reported this. The revert mentioned above has been included
> in Linus' master branch as commit 2b36209ca818  ...

Yeah, I'd seen it (I usually run his latest master branch). All has been well
since the revert (and even better since Lu Baolu found and fixed an IOMMU
regression that was also locking me up). Gotta love bleeding-edge kernels :)

Thanks,

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
