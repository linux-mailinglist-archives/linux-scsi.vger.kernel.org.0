Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F7C312F54
	for <lists+linux-scsi@lfdr.de>; Mon,  8 Feb 2021 11:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhBHKoo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 8 Feb 2021 05:44:44 -0500
Received: from mail.xenproject.org ([104.130.215.37]:50004 "EHLO
        mail.xenproject.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhBHKl5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 8 Feb 2021 05:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
        bh=IQPlMuHphzCxemau7EPG8KdIBVritDvW1xuyCMc3fhU=; b=sC+AR9iTEqeFWbDuKWB5Y35WRU
        0RbDCYD8HqDZ5+YavvWLxIKZjjBgShWRRynceb425BC8VjwpIVUA9HMJAGLCISgOYcuyi1zxNzhqU
        swR71F4tJ9r/e/ArJUxgAMKjDK+qn++/QfBSK2/QATA/oMqTo/0taQ58egBGhScfddCo=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1l93yJ-0001Vr-NE; Mon, 08 Feb 2021 10:40:47 +0000
Received: from [54.239.6.177] (helo=a483e7b01a66.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <julien@xen.org>)
        id 1l93yJ-0004LV-Ej; Mon, 08 Feb 2021 10:40:47 +0000
Subject: Re: [PATCH 0/7] xen/events: bug fixes and some diagnostic aids
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
References: <20210206104932.29064-1-jgross@suse.com>
 <bd63694e-ac0c-7954-ec00-edad05f8da1c@xen.org>
 <eeb62129-d9fc-2155-0e0f-aff1fbb33fbc@suse.com>
 <fcf3181b-3efc-55f5-687c-324937b543e6@xen.org>
 <7aaeeb3d-1e1b-6166-84e9-481153811b62@suse.com>
 <6f547bb5-777a-6fc2-eba2-cccb4adfca87@xen.org>
 <0d623c98-a714-1639-cc53-f58ba3f08212@suse.com>
From:   Julien Grall <julien@xen.org>
Message-ID: <28399fd1-9fe8-f31a-6ee8-e78de567155b@xen.org>
Date:   Mon, 8 Feb 2021 10:40:44 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0d623c98-a714-1639-cc53-f58ba3f08212@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Juergen,

On 08/02/2021 10:22, Jürgen Groß wrote:
> On 08.02.21 10:54, Julien Grall wrote:
>> ... I don't really see how the difference matter here. The idea is to 
>> re-use what's already existing rather than trying to re-invent the 
>> wheel with an extra lock (or whatever we can come up).
> 
> The difference is that the race is occurring _before_ any IRQ is
> involved. So I don't see how modification of IRQ handling would help.

Roughly our current IRQ handling flow (handle_eoi_irq()) looks like:

if ( irq in progress )
{
   set IRQS_PENDING
   return;
}

do
{
   clear IRQS_PENDING
   handle_irq()
} while (IRQS_PENDING is set)

IRQ handling flow like handle_fasteoi_irq() looks like:

if ( irq in progress )
   return;

handle_irq()

The latter flow would catch "spurious" interrupt and ignore them. So it 
would handle nicely the race when changing the event affinity.

Cheers,

-- 
Julien Grall
