Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86371AAFEF
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2020 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411214AbgDORiN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Apr 2020 13:38:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47029 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2411203AbgDORiM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 15 Apr 2020 13:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586972291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WCLSzEkHvr3tTD35txcPSsNhSLAkR3JoOAS/1WSv1G0=;
        b=d2HtMGEPdTqYjlMlx8zdzHVnhg8gvLztfIiIXeQAP2pUk91/gKzuHFRJiBpAg9ix0w9i5z
        4MsJ5PgkK86wdSKDNkKWgCqdQzwjFF0re6zPtuizotq1omfRXEdCEN/60s+7gJMu9X0ngr
        brO+h0WJiijyVNlx5E1YZU03Glqs920=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-aHy__bHwOOmhAVv4IRfEEg-1; Wed, 15 Apr 2020 13:38:07 -0400
X-MC-Unique: aHy__bHwOOmhAVv4IRfEEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1646C8017F3;
        Wed, 15 Apr 2020 17:38:06 +0000 (UTC)
Received: from [10.10.115.103] (ovpn-115-103.rdu2.redhat.com [10.10.115.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D65D3A4;
        Wed, 15 Apr 2020 17:38:05 +0000 (UTC)
Subject: Re: [RFC PATCH 3/5] target: add target_setup_session sysfs support
To:     Bart Van Assche <bvanassche@acm.org>, jsmart2021@gmail.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, nab@linux-iscsi.org
References: <20200414051514.7296-1-mchristi@redhat.com>
 <20200414051514.7296-4-mchristi@redhat.com>
 <0267ebe3-8168-ef02-b414-6d14a756277b@acm.org>
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5E97467C.1070108@redhat.com>
Date:   Wed, 15 Apr 2020 12:38:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <0267ebe3-8168-ef02-b414-6d14a756277b@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 04/14/2020 09:37 PM, Bart Van Assche wrote:
> On 2020-04-13 22:15, Mike Christie wrote:
>>  struct se_session *target_setup_session(struct se_portal_group *,
>>  		unsigned int, unsigned int, enum target_prot_op prot_op,
>> -		const char *, void *,
>> -		int (*callback)(struct se_portal_group *,
>> -				struct se_session *, void *));
>> +		const char *, struct attribute_group *, void *,
>> +		int (*setup_cb)(struct se_portal_group *,
>> +				struct se_session *, void *),
>> +		void (*free_cb)(struct se_session *));
> 
> The argument list of target_setup_session() is getting really long. How
> about moving the attribute_group, setup_cb and free_cb arguments into
> struct target_core_fabric_ops? Would that make it easier to extend

I agree.

> session sysfs attribute support in the future?
> 

Yeah, I can move those callbacks and the attribute_group to the
target_core_fabric_ops and it then it will work more similarly to the
other callout/attr handling.

