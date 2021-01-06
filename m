Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45572EB8C8
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Jan 2021 05:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbhAFEDi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 Jan 2021 23:03:38 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:25638 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFEDi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 5 Jan 2021 23:03:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609905798; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RdpOU6YwKd5+NTVSRuzfiKNUmXCbAKy7uXiBCene2Os=;
 b=YqK2/NDLHLh5yiLSesK0bCCWs+8ITMyOoSMfFzentP3M+6L3fQkcCalG5D3iRHzbnIqfYAPd
 jmcwE2CgWfvJqNu3h7EQTVjre8+SFnlCxHKhAyvNb0cZ0U+FuHLlEn4L3O1jDRG2lP0Vya/6
 h5w7xv6MqryzSHJoPE/Si+1s8Q8=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ff5366c3d849691149b12e8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Jan 2021 04:02:52
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2375C433CA; Wed,  6 Jan 2021 04:02:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7DECCC433CA;
        Wed,  6 Jan 2021 04:02:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 06 Jan 2021 12:02:51 +0800
From:   Can Guo <cang@codeaurora.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, ziqichen@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com
Subject: Re: [PATCH v8 0/3] Three changes related with UFS clock scaling
In-Reply-To: <yq1im8ag4z6.fsf@ca-mkp.ca.oracle.com>
References: <1609327777-20520-1-git-send-email-cang@codeaurora.org>
 <yq1im8ag4z6.fsf@ca-mkp.ca.oracle.com>
Message-ID: <fc7d7fdc0e2b726065ab65aa29e1fa10@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2021-01-06 10:45, Martin K. Petersen wrote:
> Can,
> 
>> This series is made based on 5.10/scsi-fixes branch.
> 
> Please rebase on top of 5.12/scsi-queue and resubmit. Thanks!

Sure Martin.
