Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDDC5124D7
	for <lists+linux-scsi@lfdr.de>; Wed, 27 Apr 2022 23:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiD0V73 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 Apr 2022 17:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbiD0V71 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 27 Apr 2022 17:59:27 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E03C116C
        for <linux-scsi@vger.kernel.org>; Wed, 27 Apr 2022 14:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651096575; x=1682632575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ndxlCJcsWNsxefRwlgceKJ0VvE3NnTsnasUGPtb8I/A=;
  b=EJ4qt9cPTlU/WnZNjoOE77bzKkCZ2N2eTRFTlDn5u3XTl/Pgo+1V0nO6
   IKebUB0DEeXobuFGaSBFL3vLRBG8IBpjGQMTNI0nC3H2L8b2VjhKvSF1i
   vOw19UGyGdmgcmhkiDPDoB0s0dAg0ZFdiTxGYV5Kah4T4QTBjjBfJn+hv
   5bKSIQBgZz2ThINXwwd9+kIisAET2f/sgoslL0tfjB3tEycqd0/SViEV0
   /GY1KgUHXzH3GTiGBPzfvnHZCp9rAl/zwu7CQSkam5z4oiKz8sCuzKlLO
   guMM6kwe2km9Z/jWzV9F8dhivhwmx5v1QIaNeHzS+Q23QYikp5gRzDtqO
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="197838686"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 05:56:11 +0800
IronPort-SDR: oHfDaHUvnY7KpsLD0dwBQCAqLVYeWxRyGct4byRtP1E5B5ykYzWVEuijgcw33D/18oac3g4UY9
 0SCtt1mF0n5Wfnphox2b7n0CQerJKN3HYWbLfnMCISdnhkG4Sdlk1zlHCkaJY4uxu8mQOmswRh
 mI+t569iQ/6Xu3MnJlJC54b3NvfnxCteoFKGArwtzbpi5Ijc2cfP9MhZwKZ/srmZsxpId6Tj90
 PbYf6VpD96oKsqaraYjpc1foIkpr91Kwj6IyiYNiYcbzL2dhcryT/fHuDqzMd4mb0hD/XVl1B5
 beCdQn9JRWScHbKBptFj1hN4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 14:27:04 -0700
IronPort-SDR: O4ZfumYnFtXAlCPH4QlrYEJHavO1NajhcAebtRIV1gOO3uQDiQpUFIadU/ETVWdXS51I78D01f
 bloUodHDrAWnuyqyshhE825xRdY/yCbTWhWLe9piN7z3NTtfCA9OhdywJbIVKNJvMA+26hLaJe
 lme3tEpLL/FkgSNRqTgzXMf+XmWZNLK9hlI+GAturGPUMRy1MFhgD2Rmo3bxhlrca5ZjSPUlsi
 hkp7JrEDHnKrPi1iMc23m3GmOPohD45zP17qalGrTwt8INjpUX7mTQY2TTH6HHi1gjO3mucrrx
 djg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 14:56:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpXd66GGkz1SVp1
        for <linux-scsi@vger.kernel.org>; Wed, 27 Apr 2022 14:56:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651096570; x=1653688571; bh=ndxlCJcsWNsxefRwlgceKJ0VvE3NnTsnasU
        GPtb8I/A=; b=ggSIi2wKa7K/Yj0CenSA293BbFt3EsVO5xG9ttkgqCfc8vV/d/d
        Z0XVADeDgci27/+2+Z8t9WQvji1Lg3kutMfer7DksmYw6OXawv3PgGI9ToBzaM49
        tR1Y4U0G2OcEDjzXxvKhA7ZVchwGk8La0omPG+TejDWIj/w9uELco8SA3POOurcL
        7VeKd1JwcE7f8F4gEnYPK543JmhyBYYfe10X74Br3eYk801Gbqr5yLRI1LbNp7Az
        nOzi/IfpTJK0pnZKUMJ7z29vv4CXJna8RlRtrEwMGFFFo5fgE0u0qkdgSNQD8Lpt
        YW261y9Jg7jwobHKsKsB77nhK8PPVM974ag==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3eod9rjk5-xd for <linux-scsi@vger.kernel.org>;
        Wed, 27 Apr 2022 14:56:10 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpXd44RlGz1Rvlc;
        Wed, 27 Apr 2022 14:56:08 -0700 (PDT)
Message-ID: <3f80a126-e52a-955b-aca4-14218d26faf5@opensource.wdc.com>
Date:   Thu, 28 Apr 2022 06:56:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <c02f67e1-2f76-7e52-8478-78e28b96b6a1@opensource.wdc.com>
 <20220427153826.GE9558@test-zns>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427153826.GE9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/28/22 00:38, Nitesh Shetty wrote:
> On Wed, Apr 27, 2022 at 10:46:32AM +0900, Damien Le Moal wrote:
>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>> The patch series covers the points discussed in November 2021 virtual=
 call
>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>> We have covered the Initial agreed requirements in this patchset.
>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>> implementation.
>>>
>>> Overall series supports =E2=80=93
>>>
>>> 1. Driver
>>> - NVMe Copy command (single NS), including support in nvme-target (fo=
r
>>>     block and file backend)
>>>
>>> 2. Block layer
>>> - Block-generic copy (REQ_COPY flag), with interface accommodating
>>>     two block-devs, and multi-source/destination interface
>>> - Emulation, when offload is natively absent
>>> - dm-linear support (for cases not requiring split)
>>>
>>> 3. User-interface
>>> - new ioctl
>>> - copy_file_range for zonefs
>>>
>>> 4. In-kernel user
>>> - dm-kcopyd
>>> - copy_file_range in zonefs
>>>
>>> For zonefs copy_file_range - Seems we cannot levearge fstest here. Li=
mited
>>> testing is done at this point using a custom application for unit tes=
ting.
>>
>> https://protect2.fireeye.com/v1/url?k=3Db14bf8e1-d0361099-b14a73ae-74f=
e485fffb1-9bd9bbb269af18f9&q=3D1&e=3Db9714c29-ea22-4fa5-8a2a-eeb42ca4bdc1=
&u=3Dhttps%3A%2F%2Fgithub.com%2Fwesterndigitalcorporation%2Fzonefs-tools
>>
>> ./configure --with-tests
>> make
>> sudo make install
>>
>> Then run tests/zonefs-tests.sh
>>
>> Adding test case is simple. Just add script files under tests/scripts
>>
>> I just realized that the README file of this project is not documentin=
g
>> this. I will update it.
>>
>=20
> Thank you. We will try to use this.
> Any plans to integrate this testsuite with fstests(xfstest) ?

No. It is not a good fit since zonefs cannot pass most of the generic tes=
t
cases.

>=20
> --
> Nitesh Shetty
>=20
>=20


--=20
Damien Le Moal
Western Digital Research
