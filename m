Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E96D3E6
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jul 2019 20:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfGRS3J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Jul 2019 14:29:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRS3J (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 18 Jul 2019 14:29:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66C7E88309;
        Thu, 18 Jul 2019 18:29:09 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-160.bos.redhat.com [10.18.17.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F016B1001B0C;
        Thu, 18 Jul 2019 18:29:08 +0000 (UTC)
Subject: Re: [PATCH] scsi: ses: Fix out-of-bounds memory access in
 ses_enclosure_data_process()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <jejb@linux.ibm.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190501180535.26718-1-longman@redhat.com>
 <1fd39969-4413-2f11-86b2-729787680efa@redhat.com>
 <1558363938.3742.1.camel@linux.ibm.com>
 <729b0751-01a6-7c0b-ce0d-f19807b59dee@redhat.com>
 <yq1blxrxkpy.fsf@oracle.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d00a1ace-bc05-301b-cd61-600b6dabf51e@redhat.com>
Date:   Thu, 18 Jul 2019 14:29:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <yq1blxrxkpy.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 18 Jul 2019 18:29:09 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/18/19 2:26 PM, Martin K. Petersen wrote:
> Waiman,
>
>> Is someone going to merge this patch in the current cycle?
> I was hoping somebody would step up and patch all the bad accesses and
> not just page 10.
>
I see.

Thanks,
Longman

