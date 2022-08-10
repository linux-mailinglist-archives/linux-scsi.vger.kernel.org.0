Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4946A58E571
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Aug 2022 05:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiHJDVt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Aug 2022 23:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiHJDVI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Aug 2022 23:21:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4A8647CD;
        Tue,  9 Aug 2022 20:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3D7AB818E4;
        Wed, 10 Aug 2022 03:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EA2C433C1;
        Wed, 10 Aug 2022 03:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660101445;
        bh=vjEy3DMtbLrahHsziT5da3Wwqjeu8cAWr/76lzTo+6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntmHLs9lVYa79wSbXJueCgmc0cWbs6zVaI1xE3DLv/orAm1A9Vvsd7U6saAbatStx
         qCSjT3rfGmNVX+BxgDBq2AIfSJvq6OOZaDFGgeXnhDXetdck9F77JsKXUxhf8LEjqz
         VmEhLFJdbKBh9ncKjY+WX09JsAXBM/Dl/19tdQfWtvhU0FP+x7Os9sUHg9kp4I52Qe
         mq/eA4o5L7wznNYjd1dEbWTr0oxGalYz/vPD80JOP0I3uP6WTnqYHFIi3Y+TdsNaOJ
         bIo2WUadkHl0nVPeVEtYkSMfVWs2E/g4g/TFCdcqud/blhMwfFZx2Y+XtU422IRRlU
         8zLnRJpeaKxfw==
Date:   Tue, 9 Aug 2022 21:17:21 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>
Subject: Re: [PATCH v2 09/20] nvme: Add helper to execute Reservation Report
Message-ID: <YvMjQSlFKJE8Cp8w@kbusch-mbp.dhcp.thefacebook.com>
References: <20220809000419.10674-1-michael.christie@oracle.com>
 <20220809000419.10674-10-michael.christie@oracle.com>
 <12b99b10-8353-0f72-f314-c453a4fc5b6a@nvidia.com>
 <YvJ0Xh61npH+M9HP@kbusch-mbp.dhcp.thefacebook.com>
 <5f55a431-31ce-185a-6ab0-db701b878d82@oracle.com>
 <a0184a51-ef30-dc80-412e-6f754c4d9476@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0184a51-ef30-dc80-412e-6f754c4d9476@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Aug 10, 2022 at 01:45:48AM +0000, Chaitanya Kulkarni wrote:
> On 8/9/22 09:21, Mike Christie wrote:
> > On 8/9/22 9:51 AM, Keith Busch wrote:
> >> On Tue, Aug 09, 2022 at 10:56:55AM +0000, Chaitanya Kulkarni wrote:
> >>> On 8/8/22 17:04, Mike Christie wrote:
> >>>> +
> >>>> +	c.common.opcode = nvme_cmd_resv_report;
> >>>> +	c.common.cdw10 = cpu_to_le32(nvme_bytes_to_numd(data_len));
> >>>> +	c.common.cdw11 = 1;
> >>>> +	*eds = true;
> >>>> +
> >>>> +retry:
> >>>> +	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
> >>>> +	    bdev->bd_disk->fops == &nvme_ns_head_ops)
> >>>> +		ret = nvme_send_ns_head_pr_command(bdev, &c, data, data_len);
> >>>> +	else
> >>>> +		ret = nvme_send_ns_pr_command(bdev->bd_disk->private_data, &c,
> >>>> +					      data, data_len);
> >>>> +	if (ret == NVME_SC_HOST_ID_INCONSIST && c.common.cdw11) {
> >>>> +		c.common.cdw11 = 0;
> >>>> +		*eds = false;
> >>>> +		goto retry;
> >>>
> >>> Unconditional retries without any limit can create problems,
> >>> perhaps consider adding some soft limits.
> >>
> >> It's already conditioned on cdw11, which is cleared to 0 on the 2nd try. Not
> >> that that's particularly clear. I'd suggest naming an enum value for it so the
> >> code tells us what the signficance of cdw11 is in this context (it's the
> >> Extended Data Structure control flag).
> > 
> 
> true, my concern is if controller went bad (not a common case but it is
> H/W afterall) then we should have some soft limit to avoid infinite
> retries.

cdw11 is '0' on the 2nd try, and the 'goto' is conditioned on cdw11 being
non-zero. There's no infinite retry here.
