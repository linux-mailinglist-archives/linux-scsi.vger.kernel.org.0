Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0935526CFBE
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Sep 2020 02:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgIQAFG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Sep 2020 20:05:06 -0400
Received: from sonic309-15.consmr.mail.bf2.yahoo.com ([74.6.129.125]:43415
        "EHLO sonic309-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgIQAFF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 16 Sep 2020 20:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600301104; bh=OBtI3XvnZP39PzLoBWLPBmhn7VDFZI0/uHui1ScbXu8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=ST/EyXCl+l+pvutzgifupBbk2zwmoC2zWcNc1syPjO3pYR/d9J52Kkm4pr60sOSg4JfZYprWKYXUmm6SXoGrDTGONlwxosQtOaKB48NnhK/MPj3IZkNT3J452TJXVfvrpLm5bdbJPpYFjF4CfvzwZGc7DBGnUFNGP566ttnHubGLUjTxDEuoCbOg3Hos1PQJP8dlRfqu9Bj8FHIHzfQNN2+9DBkfiF242lytfA0zxrW3ZdUnN0Qk5fsSE6HXpKwtHtvJrDeuWl3YurlbxdpgRLCVOVnqUshDJFuR8gq4GFs2NuNBNaubwYwu3iSs3VoboPaWevWvPuTAbl/1bzGKgQ==
X-YMail-OSG: We.wIpMVM1nh6_bBs44D8tYVIP018mewlLMRVgyd.553LJpIzYc9AT_yikrfOP2
 Evc0mM49MpqVzmzSh87VF8ckcdJRNibb2h4o3hRi2CWyfeIzIixwfYvW7Sv5L12h0.oubnHy3Bzy
 BmVcTqQ71NBRb8CAdaAVmw4NU7hdzoNSzHoPkz6aFMZpywvhUNUDkx.vOvr4V2QnjLpLPDT3I.4l
 DdDaRijDCLBiOF1dMarROnQsAhomUsmu_a_w0szHJ83UU49FUdZsG6jgDL990dcpxGhwc2ClaGSU
 bO5lTr405Frlhigxp_vm8KQJ6imkWsBidQc3bRoiMqO.LXiOFUWqj8RxHCO47tLFsREU.JHvp6ru
 hED6K9ROVjG8f2aqZ0DV.ziJCrHwOmQa_HgzrRAaW5RuiM45oo7vKddOTU9Avdi__HQNgg_WPB2e
 03ZvDILkksbFZ0HSf0hxmTWWg9Vle.pZCaX7PXtAr2iSsZWT9KwIlb3LCuAH1q3N5gt9kQufr.wD
 jElf01m_GGYJL8jnFzuxnV_D1KNyWAZAJ6S__8b0RrPuxbKFgRdR2u22BvKNg6SUjoPjdpa_toZe
 lthgJN5z.l2zZYBQ69xclK7voqofw6f3pwnwviuyLbSEA33rPqIYsh2XqQ9JIu.aWvYPZZXyUGoP
 B618Y1ZuswzNecnoluyYJL6wPb.ZdJIsauuKY9SvUAdxWrvE4En6tK3nEdrGBOBRLeDwrORYxRg7
 86tQ5kFZY38FPq7GrU8ivy_q6sFydCUR_DuOoagTenVHWinVu5EY78Zvx6WVkmHEQxzfYAuJC7ag
 Mq7PS48ZSHDzHJW4xocsR3muFQ6L1wzblQ8nNaZJpNox1YugdQOZw.Eo2lIg4bX0h2SOkL_DsrIQ
 xir.qb8ZV0URWfI869M4WJSFTd1CwvefIG9eRMixuZEvz2osf_kbrPRPGXwMxg9Q.VLTayAyWPAv
 2beNzzodwMOCbMZo0aM4JwkNfeAZUSjhF5Jo48qle5K5.s.XOHtUHjGX6dWiLu22dQyo3BHJzVsn
 aMkGJ3TQq3oYz0MaRSIJgKo83vedGbiaci08_JG2qehKwyltCGVx0RDareA_iER3tfG2JFc2rON9
 24.ZO_kNii5VVuifFYAHj1GVmGHuGkSUgi4z7Q1AMDxXnIRATL2kxf8Q4OY7L2yNRZO7Holm2nf.
 _ISgvOm9ctLvmtXXFFcD2m99bDJ3zEh_ynXWIftD3nOpS2NqIrplgT7XnVRLWpj._l5UEEcq8rN2
 OgieGlBY6xCrcj_iBhxan_FyM7AAXFXqqRD4GRV.EQrmT4SWsgBSNg0iMHoZ3Mxx4JIGCisGxdN3
 Mezjy8v3xSEx6MRUxYLbkBJT7FbihbKyWsVOQ9sY2jWed_TEducPKjRyWkeVS8ABTcwRRDw1BowC
 P1KyePX2lPEuiEJBrdLgWq6ab3f4yxw_oEKIfkN4zRcUy.IpDw63oHHG99q6QMfZoOwGUkmHhgcP
 W2UABZqS1.q4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Thu, 17 Sep 2020 00:05:04 +0000
Date:   Thu, 17 Sep 2020 00:05:03 +0000 (UTC)
From:   CUSTOMER CENTER <customercenter934@gmail.com>
Reply-To: customercenter934@gmail.com
Message-ID: <1587569209.2996341.1600301103753@mail.yahoo.com>
Subject: Greetings to you
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1587569209.2996341.1600301103753.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



Greetings to you
We are writing this letter to you from LinkedIn Company we know that this message may come to you as a surprise you have
been selected as our new-branch manager in your country; for more about the position reply us via this E-mail:
(info.customer01@consultant.com)The position cannot stop your business or the work you are doing already.
Regards.Mr.Jeff.
Whatsapp +16205060599
