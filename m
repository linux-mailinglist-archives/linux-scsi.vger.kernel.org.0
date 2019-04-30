Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4FF13E
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Apr 2019 09:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfD3HYk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Apr 2019 03:24:40 -0400
Received: from sonic310-23.consmr.mail.ne1.yahoo.com ([66.163.186.204]:33315
        "EHLO sonic310-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbfD3HYk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 30 Apr 2019 03:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1556609078; bh=dJka9g6uu3ZGnnYodeQiywj4aqYTn67ItSAv2feKoEY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mVgdHoaaLTLohHs//cCvgjvse10IYZE8j98ORMHUmPaBt5LwWguwWNdYrH0Fk+nSiovsejMuRZt78Bo+3HZNdDive1UpCfNMwLWke07X9xY29Y248xjOnjMadKiK3MdADdF9MQVLUIhVLiA+8r4vT79YRE9bCAEIQ3WAihAVq6PtESxjnFJyOXl+CeowrjmfcFZG3bNQqK//Efn3fPqr84TZe3MJpeYdwdH9BqJnrnqUXdStyeoh3/3iKCAJCH6QoG2GBfeTa4W3FCR2pfff6NIUQ8IsUsb7LSRlTGO9C/Mt1Yv7gku0LxMlYr90VL7gvwO/XX251tL13d+U4Ta/xA==
X-YMail-OSG: J9DgcMEVM1mXgqMotP1k.CojBQ5q6wbtFr76aY7cKQyywD_XkwUdN.oyUYjMSO9
 8.jNY33rOVQ.o4L.TyN7m.bDYyiFXtYhwbLl7mMMW5QLQSho8ZITCpnHXae9pKuTV794KBGxq9cJ
 noshTEZZkvzVbCBLxo.r4RfP06ZMldO.r7JV0aTrfnD_xhq7DMO8bQXjLGzolq3hKECOd2rP01Vn
 YffHZvL36zcheUgIPpdulDwVPvlA50gIKJtoljocFpE0hA3VgF3rqjmt_gWq995gyX_ctF_ma8k5
 1bCE.KRXP9nXxVsRXyqvvG1AzVFVR6BpSL8BQgJeGu6BtiUHNqMTMamvNlBFxAcnkM0D_nGNgAkd
 HH0GvSV0Njt0GqEVvJ0qVCxNWO8gwYl0aOe5QMt8ZXmNR4NwcT1oy67S2DozLEoEL8ZUUh8bb.ds
 7t7rOTGSDjJUht291sNhvGj8Vx1aCzpuNmSWYDoN6lakNnzPVjVbms6SzC2eUbHGsljAZ7QlH2iI
 YLky6QfJgYL_syzQkuOHfSoIZ7k1ZjqkgKI6CTj18yT.jX_w6sNbTJevwoxUBMy0jxfTXgYpYVeC
 F0kyB3AlD_r6ATbGgZCq0AQMTvhSQbGpsHM5dBZmF7M2hKh9e24GgbR1wFWOWQubbiqJSpVzGUgZ
 MjcpJTBWAqSc2U5eb3nqzIazO.Q0PdoBuXplg9sATeq64abTYCSvgcxP0TJ8rxxXiS2.1VN1aAsq
 mJO805DUr6cR7LOHE22Y77GEYV9niZGiXj9AbrVGqOAJ609OXIwN.2VNjd3z.oi50yOkegu0OLjk
 wy24ypatcvE044wFx_hxAYD9ndroMGPYbauXeeMcVQFGDS9vqAmu40pOOe9XHuURcP0kPC0Nx5jB
 Ccpcf4rCUMZJedrcvnTrCyHRqE6aXNsp9K6gr.keoUkzjZDzizu9GE2lXXOCXbJy2lAyTT6Rzfne
 G7qmDBwbPi0GRYqiGQXzyAWMjbnpKfk8zKmrVVjPu2EndWqwkjsTX2APliWdT20ulnsrjiv3sA18
 p5mR343EwG39c1YFOpyl81_C2g8Yca1CKurV_6wOXFDHalDdIsKjEes68UR5ktJVr673L.OLscP8
 M1IwYs0YSJwtfok1IBpMprcbpX_J6YoDj6SA8rGDFDju2m9Jj3FMstDOf.vD0v7xYvBulYvMUQ1m
 _Ukd5Tg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Apr 2019 07:24:38 +0000
Date:   Tue, 30 Apr 2019 07:24:34 +0000 (UTC)
From:   "Mrs Amina.Kadi" <mrrasaq.saud3@outlook.fr>
Reply-To: "Mrs Amina.Kadi" <mrsamina.kadi1@barid.com>
Message-ID: <1013701068.2571359.1556609074830@mail.yahoo.com>
Subject: Compliment of the day to you Dear Friend.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1013701068.2571359.1556609074830.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13554 YahooMailBasic Mozilla/5.0 (Windows NT 6.1; rv:66.0) Gecko/20100101 Firefox/66.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



Compliment of the day to you Dear Friend.

Dear Friend.
 
  I am Mrs. Amina Kadi. am sending this brief letter to solicit your
partnership to transfer $5.5 million US Dollars. I shall send you
more information and procedures when I receive positive response from
you.

Mrs. Amina Kadi
